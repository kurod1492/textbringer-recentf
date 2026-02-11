# frozen_string_literal: true

require_relative "recentf/version"

module Textbringer
  CONFIG[:recentf_max_items] = 100
  CONFIG[:recentf_file] = File.expand_path("~/.textbringer/recentf")
  CONFIG[:recentf_exclude_patterns] = [
    %r{^/tmp/},
    %r{COMMIT_EDITMSG$}
  ]

  module Recentf
    @last_added = nil

    class << self
      attr_accessor :last_added

      def file_path
        File.expand_path(CONFIG[:recentf_file])
      end

      def max_items
        CONFIG[:recentf_max_items]
      end

      def exclude_patterns
        CONFIG[:recentf_exclude_patterns]
      end

      def load
        return [] unless File.exist?(file_path)
        File.readlines(file_path, chomp: true)
      end

      def save(list)
        dir = File.dirname(file_path)
        FileUtils.mkdir_p(dir) unless File.directory?(dir)
        File.write(file_path, list.take(max_items).join("\n") + "\n")
      end

      def add(path)
        return if path.nil? || path.empty?
        path = File.expand_path(path)
        return if exclude_patterns.any? { |pat| pat.match?(path) }
        return if path == last_added

        list = load
        list.delete(path)
        list.unshift(path)
        save(list)
        self.last_added = path
      end

      def cleanup
        list = load.select { |f| File.exist?(f) }
        save(list)
        list.size
      end
    end
  end

  define_command(:recentf, doc: "Open a file from recent file history.") do
    list = Recentf.load
    if list.empty?
      raise EditorError, "No recent files"
    end

    completion_proc = ->(s) {
      list.select { |f| f.include?(s) }
    }
    file = read_from_minibuffer("Recent file: ",
                                completion_proc: completion_proc,
                                history: list)
    find_file(file)
  end

  define_command(:recentf_cleanup,
                 doc: "Remove non-existent files from recent file history.") do
    count = Recentf.cleanup
    message("Cleaned up. #{count} files remaining.")
  end

  # Track buffer switches to files
  # Cannot use this_command check because recursive_edit in minibuffer
  # clears this_command before post_command_hook runs
  add_hook(:post_command_hook) do
    file = Buffer.current&.file_name
    if file && !file.empty?
      Recentf.add(file)
    end
  end

  # Record files specified on command line (txtb filename)
  # foreground runs after command_loop starts, when files are already opened
  foreground do
    ARGV.each do |arg|
      path = File.expand_path(arg)
      Recentf.add(path) if File.exist?(path)
    end
  end
end

# textbringer-recentf

Emacs-like recent file history plugin for [Textbringer](https://github.com/shugo/textbringer).

## Dependencies

- [textbringer](https://github.com/shugo/textbringer) >= 1.4
- [textbringer-minibuffer-extension](https://github.com/kurod1492/textbringer-minibuffer-extension) >= 0.1.0

## Installation

### Via RubyGems

```bash
gem install textbringer-recentf
```

### Via Bundler

Add this line to your Gemfile:

```ruby
gem 'textbringer-recentf'
```

Then execute:

```bash
bundle install
```

### Manual Installation

Clone this repository to your Textbringer plugins directory:

```bash
git clone https://github.com/kurod1492/textbringer-recentf.git ~/.textbringer/plugins/textbringer-recentf
```

## Configuration

Add the following to your `~/.textbringer.rb`:

```ruby
# Key binding (optional)
GLOBAL_MAP.define_key("\C-x\C-r", :recentf)

# Maximum number of files to remember (default: 100)
CONFIG[:recentf_max_items] = 100

# History file path (default: ~/.textbringer/recentf)
CONFIG[:recentf_file] = "~/.textbringer/recentf"

# Patterns to exclude from history
CONFIG[:recentf_exclude_patterns] = [
  %r{^/tmp/},
  %r{COMMIT_EDITMSG$}
]
```

## Usage

| Command | Description |
|---------|-------------|
| `M-x recentf` | Open a file from recent history |
| `M-x recentf_cleanup` | Remove non-existent files from history |

## License

MIT

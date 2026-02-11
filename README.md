# textbringer-recentf

Emacs-like recent file history plugin for [Textbringer](https://github.com/shugo/textbringer).

## Dependencies

- [textbringer](https://github.com/shugo/textbringer) >= 1.4
- [textbringer-minibuffer-extension](https://github.com/kurod1492/textbringer-minibuffer-extension) >= 0.1.0

## Installation

### Via git clone

Clone this repository and its dependency to your Textbringer plugins directory:

```bash
# Install dependency
git clone https://github.com/kurod1492/textbringer-minibuffer-extension.git ~/.textbringer/plugins/textbringer-minibuffer-extension

# Install this plugin
git clone https://github.com/kurod1492/textbringer-recentf.git ~/.textbringer/plugins/textbringer-recentf
```

### Via rake install

After checking out the repo, run `bundle install` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`.

Note: You also need to install the dependency [textbringer-minibuffer-extension](https://github.com/kurod1492/textbringer-minibuffer-extension).

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

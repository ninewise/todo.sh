
# TODO's

Each source is a plugin, specified in one of the subdirectories of this repository and activated by adding it's configuration section to the configuration file. (For now, all plugins in the `enabled` directory are enabled. Configure by editing the plugins.) An example plugin would be notmuch, to add mails as items. Each plugin should provide in it's directory:

  - A `list` script which list entries for unresolved items of this plugin in tsv format (seconds since epoch, identifier, summary);
  - A `show` script (e.g. `notmuch show`) which shows the complete item;

All other executables (of which there must be at least one) are considered resolving scripts, e.g.:

  - A `archive` script (e.g. `notmuch tag +archived -unread`) which archives the given identifier;
  - A `kill` script (e.g. `notmuch tag +killed -unread`) which throws the given identifier in the bin.

Should a resolving script exit normally, the item is considered as resolved. These don't do anything for now. It's just a reader.

# Gered's Gentoo Overlay

This is my Gentoo overlay, just for my own personal use. This is essentially what I
used to have in my local ebuild repository, but I decided to put it here in this
Git repository so I can easily sync changes to all my Gentoo systems.

**You probably don't want to use this. I reserve the right to break things randomly.**

### Usage

Add a new file `/etc/portage/repos.conf/gered.conf` with the following in it:

```text
[gered]
location = /var/db/repos/gered
sync-type = git
sync-uri = https://github.com/gered/gentoo-overlay.git
auto-sync = yes
priority = 100
```

You may not want the `priority` set so high as I have it here.

And then just do an `emerge --sync` and you're done.

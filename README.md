# Nix flake for unsilence

This repo has a [nix](https://nixos.org/manual/nix/stable/) package
for [https://github.com/lagmoellertim/unsilence]. This software will
speed up gaps in videos where nobody is speaking.

To use it, type something like:

```bash
nix run github:rvl/pkg-unsilence -- -y -t4 input_file output_file
```

To install the `unsilence` command in your user's profile, run:

```bash
nix profile install github:rvl/pkg-unsilence
```

## Tips

You may wish to use this program in conjunction with
[youtube-dl](https://youtube-dl.org/), which can fetch video files
from many sources (e.g. YouTube, Google Drive, Udemy).

If watching the video requires logging in, then you can instruct
`youtube-dl` to use the session cookies from your web browser.

Use the [Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid) Chrome extension
or [cookies.txt](https://github.com/lennonhill/cookies-txt) Firefox add-on to export your browser's cookies.

Like this for example:

```bash
nix run nixpkgs#youtube-dl -- --cookies ~/Downloads/google.com_cookies.txt \
    'https://drive.google.com/file/d/MDZlohs1znRq3W1adha5ru0_izVXoaMhe/view'
```

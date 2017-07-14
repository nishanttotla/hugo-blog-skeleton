+++
authors = []
categories = []
date = "2016-04-13T14:18:26-07:00"
description = "Using Keybase? Start signing your Git commits with a GPG key"
draft = false
socialsharing = true
tags = ["security", "git", "github", "keybase"]
title = "Signing Git Commits with a GPG Key"
metaimage = "/images/keybase-io/verified-commits.png"
aliases = ["/blog/signing-git-commits-gpg/"]

+++

In my [last post](/blog/playing-with-keybase-io/), I described public key encryption and how you can generate new PGP keys using [Keybase](https://keybase.io/). That was just a start, and PGP keys have several uses. One of the first things I wanted to do was to start signing all my Git commits.

### Why Sign Commits?
Recent versions of Git (v1.7.9 and above) introduced the ability to sign commits using a GPG key. A signed commit can be verified to make sure that you wrote the code that you claim you did. If you write software as part of a small team where everyone physically meets each other, you likely don't need to do it, but for many open source projects where contributors often never meet physically, [this becomes important](https://mikegerwitz.com/papers/git-horror-story).

At Docker, we ask contributors to sign their commits using their email id (the `-s` option)
```
$ git commit -s -m "commit message"
```
This doesn't do much, except for adding a `Signed-off-by` line to your commit message, picking up your [name and email](https://help.github.com/articles/setting-your-email-in-git/) from the Git config.
```
$ git log -1
commit 17cc085744936123a023b1535f9adadd2f180332
Author: Nishant Totla <nishanttotla@gmail.com>
Date:   Thu Apr 7 14:17:32 2016 -0700

    commit message

    Signed-off-by: Nishant Totla <nishanttotla@gmail.com>
```
This is obviously easy to fake, and not as trustworthy as signing your commits with a trusted GPG key.

If you're new to encryption, this guide will hopefully help you get started with signing commits. I use a Mac, so make sure to adapt instructions to your environment. If you already have GPG installed, and a key in your keyring, then you can jump to the second half.

### Setting up a Key
This article focuses on exporting your Keybase key to GPG, and moving from there. If you want to generate a key using GPG, there are [other articles](https://help.ubuntu.com/community/GnuPrivacyGuardHowto) you might want to read first.

Install GPG using Homebrew
```
$ brew install gpg
```
This is a fresh install, and we generated a PGP key using Keybase earlier (so it's not part of the GPG keyring). It can be exported easily though
```
$ keybase pgp export --secret > secret-key.asc
```
This stores the secret key into the file `secret-key.asc`. This is temporary and MUST be deleted as soon as the import to GPG is finished
```
$ gpg --allow-secret-key-import --import secret-key.asc
gpg: key 9B3D0C19: secret key imported
gpg: key 9B3D0C19: public key "Nishant Totla <nishanttotla@gmail.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
```
The import succeeded, `9B3D0C19` is the shortened public key signature. Make sure you delete `secret-key.asc`. If you type `gpg --list-keys`, you should be able to see the key that was just added.

### Adding the Key to Git Config
Git needs to know which key to sign your commits with. Providing that information is dead simple!
```
$ git config --global user.signingkey 9B3D0C19
```
You can also set a project-specific key with the `--local` flag instead. That's it! Now you can start signing commits with the `-S` flag
```
$ git commit -S -m "commit message"
```
Note that `-S` is different from `-s`. The former signs with a GPG key, the latter only adds a `Signed-off-by` line to the commit message. You can certainly use both together.

It's easy to forget `-S` each time, but fortunately Git allows you add a setting to always sign commits

```
$ git config --global commit.gpgsign true
```

### Updating Trust Level for the Key
If you tried a commit with the new setup, and checked the commit logs, you might see a small issue

```
$ git log --show-signature -1
commit 302a1df09726ca7387b7b4ce089cfedc5fafef88
gpg: Signature made Tue Apr 12 16:14:13 2016 PDT using RSA key ID 9B3D0C19
gpg: Good signature from "Nishant Totla <nishanttotla@gmail.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 672F 675C 8084 5DE2 C29A  CFD3 7EA5 781C 9B3D 0C19
Author: Nishant Totla <nishanttotla@gmail.com>
Date:   Tue Apr 12 16:14:13 2016 -0700

    commit message

    Signed-off-by: Nishant Totla <nishanttotla@gmail.com>
```

See the warning? It's because GPG doesn't know if this is a trusted key. That can be fixed by interactively editing they key

```
$ gpg --edit-key 9B3D0C19
gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

pub  4096R/9B3D0C19  created: 2016-04-08  expires: 2032-04-04  usage: SC
                     trust: unknown       validity: unknown
[ unknown] (1). Nishant Totla <nishanttotla@gmail.com>

gpg>
```
This opens a console to edit the key. In the console, type `trust` and set the key to highest trust level.
```
gpg> trust
pub  4096R/9B3D0C19  created: 2016-04-08  expires: 2032-04-04  usage: SC
                     trust: unknown       validity: unknown
[ unknown] (1). Nishant Totla <nishanttotla@gmail.com>

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

pub  4096R/9B3D0C19  created: 2016-04-08  expires: 2032-04-04  usage: SC
                     trust: ultimate      validity: unknown
[ unknown] (1). Nishant Totla <nishanttotla@gmail.com>
Please note that the shown key validity is not necessarily correct
unless you restart the program.

gpg> quit
```
To check that it worked
```
$ gpg --list-keys --list-options show-uid-validity
/Users/NishantTotla/.gnupg/pubring.gpg
--------------------------------------
pub   4096R/9B3D0C19 2016-04-08 [expires: 2032-04-04]
uid       [ultimate] Nishant Totla <nishanttotla@gmail.com>
```
Note that `[ultimate]` now shows up in the details. Try looking at commit logs again, and the problem should be fixed!
```
$ git log --show-signature -1
commit f2de8c24b72c2978126899dbe49cb8c9973ae00b
gpg: Signature made Tue Apr 12 17:14:00 2016 PDT using RSA key ID 9B3D0C19
gpg: Good signature from "Nishant Totla <nishanttotla@gmail.com>"
Author: Nishant Totla <nishanttotla@gmail.com>
Date:   Tue Apr 12 17:14:00 2016 -0700

    commit message, this time with no warning

    Signed-off-by: Nishant Totla <nishanttotla@gmail.com>
```
Note that it's also possible to [sign tags and merge commits](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work).

### (Optional) Upload your Public Key to Github
Github [recently announced](https://github.com/blog/2144-gpg-signature-verification) that they would start showing a "Verified" tag on commits that were signed with a known GPG key. This requires uploading your public key to Github, so that it can verify signatures. You can do this in account settings

<figure>
    <img data-action="zoom" src="/images/keybase-io/settings-list.png" style="width:20%; float: left"></img>
    <img data-action="zoom" src="/images/keybase-io/github-gpg-key-upload.png" style="width:76%;"></img>
    <figcaption>This is the same public key that's on my Keybase profile.</figcaption>
</figure>

Github will now show a cool green tag against your signed commits!
<figure>
    <img data-action="zoom" src="/images/keybase-io/verified-commits.png" style="width:90%;"></img>
    <figcaption>You can click on the tag to check the associated public key.</figcaption>
</figure>

If you faced any issues with these instructions, I'd love to hear feedback!
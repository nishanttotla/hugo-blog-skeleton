+++
authors = []
categories = ["Technical"]
date = "2016-04-06T10:10:15-07:00"
description = "My initial experience with trying out keybase.io"
draft = true
socialsharing = true
tags = ["security", "keybase"]
title = "Playing with Keybase.io"

+++

I have to admit, despite having spent so many years studying Computer Science, my understanding of security and modern best practices is pretty shabby. I'm fixing that now, and one of the things I've been meaning to do for a while is try [keybase.io](https://keybase.io/). It's not even in Beta yet, and you need an invitation to try it (or sign up and join the waitlist). I was invited by a friend recently, and wanted to write about my experience trying it out. But before that, let's briefly talk about public key encryption.

### A Primer on PGP/GPG encryption
Pretty Good Privacy (PGP) was a program created to encrypt/decrypt data in 1991, which was later incorporated into a company and is now owned by Symantec. Later, an open standard called OpenPGP was created, which contained the formats for keys, encrypted messages, and message signatures defined by PGP. Thus, any other software that implemented the OpenPGP standard could interact with PGP. The GNU Privacy Guard (GPG) is one such implementation. It's open source, part of the GNU project, and has become standard software, powering a huge chunk of encryption on the web.

The way these work is that you first generate a public and private key using a program on your computer. The private key should only be accessible by you, while the public key can be sent to anyone. When someone wants to send a message, they encrypt it using your public key. This is equivalent to a mathemtical operation that's computationally very hard to reverse, unless you have the private key. On the other hand, you can use your private key to "sign" a message, which can only be decrypted using your public key. This is useful to prove that the message is indeed coming from you. This shows how you can send a verified (signed) and encrypted message to a friend that is secure and tamper-evident[^1].

#### The Web of Trust
Some important questions now need to be asked of OpenPGP compatible systems -- how sure are you that the person who sent you an encrypted message actually holds the private key that signed it? Or how do you know that the public key you used to encrypt an important message doesn't actually belong to an impostor? The point is that it's not enough to have encryption, you also need to be able to trust ownership of keys.

There are typically two ways to solve this problem - either using a hierarchical Public Key Infrastructure (PKI), or the Web of Trust. The former relies on an implicitly trusted authority to certify public keys. If the authority certifies a user, then you can trust them. In the latter, individuals who own keys can vouch for each other. Suppose Alice trusts Bob, and wants to vouch for him, she can do so by signing his public key, thereby guaranteeing to everybody that Bob's key indeed does belong to Bob. Of course, someone needs to vouch for Alice, and so on. What this does is that it creates a "web" of trust, with individuals certifying each other. Now if you're wondering if you can trust Edward, you need to find someone who trusts someone who trusts someone ... eventually leading to Edward. The more such paths to Edward you can find, the better.

This is an oversimplification, and there are many interesting technical details which I encourage you to read online. Additionally, PGP and GPG have had interesting histories, which are also worth reading.

### So What is Keybase?
Keybase is a trusted database for public keys, where you can list your public encryption key, so that anyone wishing to send you an encrypted message can use it to do so. Even though public key encryption has been around for a while, it has usually been confined to security experts and enthusiasts, partly because most tools/clients have been notoriously [hard to use](https://ariejan.net/2014/04/03/pretty-difficult-privacy/), and mainstream software hasn't really integrated encryption as a first-class feature. Keybase is aiming to solve this problem by making it easy to generate and manage keys and devices, essentially bringing encryption to the masses.

Keybase also uses a different approach to establishing trust, using your accounts on public websites, instead of relying on a web of trust. If you trust that I control the <a title="Twitter" href="https://twitter.com/nishanttotla"><i class="icon-twitter"></i>/nishanttotla</a>, <a title="Github" href="https://github.com/nishanttotla"><i class="icon-github-circled"></i>/nishanttotla</a>, etc. accounts, then all of them saying that my public key is indeed mine gives you more confidence in my public key. Because who am I, if not the sum of my online presence? 😸

It now also allows you to manage keys on individual devices, so that it's possible to notify others when you lose access to a device. Finally, the recently released [Keybase File System](https://keybase.io/docs/kbfs) allows you to create public, signed directories and securely share files.

### Getting Started
The signup process is straightforward, you create an account on the website. From that point, you can do all of the following operations using the website, the official Keybase command line client, or your own GPG setup. I chose the second one. Installing the client is easy using Homebrew.
```
$ brew install keybase
```
Once this is done, we can log in.
```
$ keybase login
▶ INFO Saving /Users/NishantTotla/Library/LaunchAgents/homebrew.mxcl.keybase.plist
▶ INFO Starting homebrew.mxcl.keybase
How would you like to sign this install of Keybase?

(1) Use an existing device
(2) Use a paper key
(3) Use my Keybase passphrase
Choose a signing option: 3
Your keybase username or email address: <username>
Please enter the Keybase passphrase for nishanttotla (12+ characters): *****
Enter a public name for this device: <device-name>

===============================
IMPORTANT: PAPER KEY GENERATION
===============================

During Keybase's alpha, everyone gets a paper key. This is a private key.
  1. you must write it down
  2. the first two words are a public label
  3. it can be used to recover data
  4. it can provision new keys/devices, so put it in your wallet
  5. just like any other device, it'll be revokable/replaceable if you lose it

Your paper key is

  ****** ****** ****** ****** ******

Write it down....now!

Have you written down the above paper key? [y/N] y
```
Really straightforward, and it also additionally generates a "paper key", which can be used to authenticate and provision Keybase on other devices (so that you don't have to move your PGP key around or enter your password each time you install Keybase on a new machine). Of course, once the phone app is released, there will be more ways of doing this.

Keybase lets you generate your own PGP key as follows, although you can use a pre-existing key too.

```
$ keybase pgp gen
Enter your real name, which will be publicly visible in your new key: Nishant Totla
Enter a public email address for your key: email1@email1.com
Enter another email address (or <enter> when done): email2@email2.com
Enter another email address (or <enter> when done):
Push an encrypted copy of your new secret key to the Keybase.io server? [Y/n] n
▶ INFO PGP User ID: Nishant Totla <email1@email1.com> [primary]
▶ INFO PGP User ID: <email2@email2.com>
▶ INFO Generating primary key (4096 bits)
▶ INFO Generating encryption subkey (4096 bits)
▶ INFO Generated new PGP key:
▶ INFO   user: Nishant Totla <nishanttotla@gmail.com>
▶ INFO   4096-bit RSA key, ID 7EA5781C9B3D0C19, created 2016-04-07
```
Great! This created a public-private key pair that I can now use to send encrypted messages to people, or sign stuff. The final line above is the public key fingerprint, also listed on [my Keybase account](https://keybase.io/nishanttotla). Notice that you have the option to upload an encrypted copy of your private key to the Keybase server[^2].

### Adding Trust Using Public Accounts
So far, nobody has reason to trust the public key on my Keybase profile. Let's use my Twitter account to add trust. Here's how this is done using Keybase client.

```
$ keybase prove twitter nishanttotla
Please publicly tweet the following, and don't delete it:

Verifying myself: I am nishanttotla on Keybase.io. MNlQinOzwmC6qk6SOsO9cifW549sLaBqfK9t / https://keybase.io/nishanttotla/sigs/MNlQinOzwmC6qk6SOsO9cifW549sLaBqfK9t
```
Keybase generates a message signed with my private key, and asks me to tweet it. Now the Keybase server can confirm that the public key listed there matches the private key that generated the signed message on the tweet.
<blockquote class="twitter-tweet tw-align-center" data-lang="en"><p lang="en" dir="ltr">Verifying myself: I am nishanttotla on Keybase.io. MNlQinOzwmC6qk6SOsO9cifW549sLaBqfK9t / <a href="https://t.co/EkAZ8KA8si">https://t.co/EkAZ8KA8si</a></p>&mdash; Nishant Totla (@nishanttotla) <a href="https://twitter.com/nishanttotla/status/718322059617681408">April 8, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
Once Keybase finds the tweet, success!

```
Check Twitter now? [Y/n] Y
Couldn't find posted proof.
Check Twitter again now? [Y/n] Y
▶ NOTICE Success!
```

The same works for [Github](https://gist.github.com/nishanttotla/06b5ea86a3a7a5ba94e83136079118ba), [personal website](http://nishanttotla.com/keybase.txt)[^3], etc. After all this, I've basically accomplished the following:

- Generated a new PGP key pair, with the private key on my laptop
- Generated a paper key that I could use to authenticate the Keybase client on more devices
- Verified ownership of this key pair by posting to public websites

All of these are connected as shown below

<figure>
    <img data-action="zoom" src="/images/keybase-io/keybase-graph.png" style="width:100%;"></img>
    <figcaption>Keybase constructs this graph for you, showing all your keys and claimed accounts. As more keys and devices are provisioned, the graph grows and becomes more complex.</figcaption>
</figure>

Now, I'm ready to send and receive verified encrypted messages! It's possible to use the client to create encrypted messages for a Keybase user (or even a non user if you have their public key). I'll send a message to [Riyaz](https://keybase.io/riyazdf), who originally invited me to the site.

```
$ keybase pgp encrypt riyazdf -s -m "Hey thanks for inviting me to Keybase. Could you please proofread this blog post for me?"
▶ INFO Identifying recipient riyazdf
✔ <tracked> public key fingerprint: 64B4 0338 48C7 49D3 92B5 8F4A 3796 809B 8CD0 E0B5
You last tracked riyazdf on 2016-04-08 09:52:28 PDT
✔ <tracked> "riyazdf" on twitter: https://twitter.com/riyazdf/status/684440359720497153 [cached 2016-04-09 14:14:28 PDT]
✔ <tracked> "riyazdf" on github: https://gist.github.com/2a59aa8a5af53024d5c9 [cached 2016-04-09 14:14:29 PDT]
-----BEGIN PGP MESSAGE-----
Version: Keybase Go 1.0.14 (darwin)
Comment: https://keybase.io/download

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
=pl6M
-----END PGP MESSAGE-----
```
Now I can send the message using any email client, and only Riyaz would be able to read it. Keybase automatically managed the retrieval of his public key, verified social proofs etc. If anything had changed since I last tracked him, I'd get a meaningful error message -- very simple and non-complicated! Note that only Riyaz can read this message since he owns his private key, and I believe that becuase of his Twitter an Github proof. What's even cooler is I could have used the Twitter handle to do the same (it's the same as the Keybase handle for Riyaz, but it could have been different), since it's connected to the PGP key. So basically

```
$ keybase pgp encrypt riyazdf@twitter -s -m "Hey it's me again."
```
This is really cool!

### My Impression
Very user friendly, and good design. Constantly showing how to do it in command line, web etc.

### What Can Go Wrong?
Twitter etc. compromised? All compromised?
Keybase account compromised?
Keybase server hacked?
Client is open source: https://github.com/keybase/client
npm issues? (not anymore I suppose)

### Some Relevant Links
I've deliberately left out a lot of details from this post to make it more accessible. If you'd like to read further, here's a set of links I pulled up (not exhaustive):

- [Difference between PGP and GPG](http://askubuntu.com/questions/186805/difference-between-pgp-and-gpg)
- [RFC 4880 (OpenPGP Message Format)](https://tools.ietf.org/html/rfc4880)
- [What Keybase is Really Doing](https://keybase.io/docs/server_security)
- [Keybase's New Key Model](https://keybase.io/blog/keybase-new-key-model)
- [Web of Trust](https://en.wikipedia.org/wiki/Web_of_trust)
- [What is Keybase in layman terms](https://www.quora.com/What-is-Keybase-in-laymans-terms)
- [PGP Web of Trust: Core Concepts Behind Trusted Communication](https://www.linux.com/learn/pgp-web-trust-core-concepts-behind-trusted-communication)
- [Can I use a private key as a public key and vice versa?](http://security.stackexchange.com/questions/9957/can-i-use-a-private-key-as-a-public-key-and-vice-versa)

Please feel free to suggest more links, or updates to the post!

[^1]: Tamper-evident means that if the message was tampered with along the way, it would be clear because it wouldn't be possible to decrypt it using the matching public or private key.
[^2]: I chose not to, and there are several concerns, implications, and reasons around why one may want to do it (or not). [This thread](https://github.com/keybase/keybase-issues/issues/160) might be helpful.
[^3]: nishanttotla.com is now verified.
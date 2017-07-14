+++
authors = []
categories = []
date = "2016-04-11T10:10:15-07:00"
description = "My initial experience with trying out keybase.io"
draft = false
socialsharing = true
tags = ["security", "keybase"]
title = "Playing with Keybase.io"
metaimage = "/images/keybase-io/pgp-xkcd.png"
aliases = ["/blog/playing-with-keybase-io/"]

+++

I have to admit, despite having spent so many years studying Computer Science, my understanding of security and modern best practices is pretty shabby. I'm fixing that now, and it was a perfect opportunity when a friend invited me to try [keybase.io](https://keybase.io/). It's still an Alpha product, and invite-only (or sign up and join the waitlist). I learned new things while trying it out, and wanted to write about it.

### A Primer on PGP/GPG encryption
Pretty Good Privacy (PGP) was a program created to encrypt/decrypt data back in 1991, and was later incorporated into a company that is now owned by Symantec. Later, an open standard called OpenPGP was created, which contained the formats for keys, encrypted messages, and message signatures defined by PGP. Thus, any other software that implemented the OpenPGP standard could interact with PGP. The GNU Privacy Guard (GPG) is one such implementation. It's open source, part of the GNU project, and has become standard software, powering a huge chunk of encryption on the web.

The way these work is that you first generate a public and private key using a program on your computer. As the names suggest, the private key is a secret, while the public key can be made available publicly. When someone wants to send a message, they encrypt it using your public key. This is equivalent to a mathematical operation that's computationally very hard to reverse, unless you have the corresponding private key. On the other hand, you can use your private key to "sign" a message, which can only be decrypted using your public key. This is useful to prove that the message is indeed coming from you[^1]. This shows how you can send a verified (signed) and encrypted message to a friend that is secure and tamper-evident[^2].

#### The Web of Trust
Some important questions now need to be asked of OpenPGP compatible systems -- how sure are you that the person who sent you an encrypted message actually holds the private key that signed it? Or how do you know that the public key you used to encrypt an important message doesn't actually belong to an impostor? The point is that it's not enough to have encryption, you also need to be able to trust ownership of keys.

There are typically two ways to solve this problem - either using hierarchical Public Key Infrastructure (PKI), or the Web of Trust. The former relies on an implicitly trusted authority to certify public keys. If the authority certifies a user, then you can trust them. In the latter, individuals who own keys can vouch for each other. Suppose Alice trusts Bob, and wants to vouch for him, she can do so by signing his public key, thereby guaranteeing to everybody that Bob's key indeed does belong to Bob. Of course, someone needs to vouch for Alice, and so on. What this does is that it creates a "web" of trust, with individuals certifying each other. Now if you're wondering if you can trust Edward, you need to find someone who trusts someone who trusts someone ... eventually leading to Edward. The more such paths to Edward you can find, the better.

This is an oversimplification, and there are many interesting technical details which I encourage you to read online. Additionally, PGP and GPG have had interesting histories, which are also worth reading.

### So What is Keybase?
Keybase is a trusted database for public keys, where you can list your public encryption key, so that anyone wishing to send you an encrypted message can use it to do so. Even though public key encryption has been around for a while, it has usually been confined to security experts and enthusiasts, partly because most tools/clients have been notoriously [hard to use](https://ariejan.net/2014/04/03/pretty-difficult-privacy/), and mainstream software hasn't really integrated encryption as a first-class feature. Keybase is aiming to solve this problem by making it easy to generate and manage keys and devices, essentially bringing encryption to the masses.

<figure>
    <img data-action="zoom" src="/images/keybase-io/pgp-xkcd.png" style="width:40%;"></img>
    <figcaption>"If you want to be extra safe, check that there's a big block of jumbled characters at the bottom." (Source: <a href="https://xkcd.com/1181/">xkcd/1181</a>, joking that even the existence of a signature likely means it's genuine.)</figcaption>
</figure>

Keybase also uses a different approach to establishing trust, using your accounts on public websites, instead of relying on a web of trust. If you trust that I control the <a title="Twitter" href="https://twitter.com/nishanttotla"><i class="icon-twitter"></i>/nishanttotla</a>, <a title="Github" href="https://github.com/nishanttotla"><i class="icon-github-circled"></i>/nishanttotla</a>, and <a title="Hacker News" href="https://news.ycombinator.com/user?id=nishanttotla"><i class="icon-hacker-news"></i>/nishanttotla</a> accounts, then all of them saying that my public key is indeed mine gives you more confidence in my public key. It's [difficult](http://greglturnquist.com/2014/10/what-keybase-is-and-is-not-and-why-im.html) to establish a web of trust, especially with people that you don't meet face to face that often. But the more public accounts under my name can verify my public key, the more trustworthy it becomes. Besides who am I, if not the sum of my online presence? 😸

Keybase now also allows you to manage multiple devices and them share keys, without actually having to move private keys around directly. Finally, the recently released [Keybase File System](https://keybase.io/docs/kbfs) allows you to create public, signed directories and securely share files.

### Getting Started
The signup process is straightforward, you create an account on the website. From that point, you can do all of the following operations using the website, the official Keybase command line client, or your own GPG setup. I chose the second one. Installing the client is easy using Homebrew.
```
$ brew install keybase
```
Once this is done, you can log in.
```
$ keybase login
▶ INFO Saving /Users/NishantTotla/Library/LaunchAgents/homebrew.mxcl.keybase.plist
▶ INFO Starting homebrew.mxcl.keybase
How would you like to sign this install of Keybase?

(1) Use an existing device
(2) Use a paper key
(3) Use my Keybase passphrase
Choose a signing option: 3
Your keybase username or email address: nishanttotla
Please enter the Keybase passphrase for nishanttotla (12+ characters): *****
Enter a public name for this device: Nishant-MBP

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
Really straightforward, and it also additionally generates a "paper key", which can be used to authenticate and provision Keybase on other devices. Of course, once the phone app is released, there will be more ways of doing this.

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
Great! This created a public-private key pair that I can now use to send encrypted messages to people, or sign stuff. The final line above is the public key fingerprint, also listed on [my Keybase account](https://keybase.io/nishanttotla). Notice that you have the option to upload an encrypted copy of your private key to the Keybase server[^3].

### Adding Trust Using Public Accounts
So far, nobody has reason to trust the public key on my Keybase profile. Let's use my Twitter account to remedy that.

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

Similar proofs are generated for [Github](https://gist.github.com/nishanttotla/06b5ea86a3a7a5ba94e83136079118ba), [personal website](http://nishanttotla.com/keybase.txt), etc. After all this, I've basically accomplished the following:

- Generated a new PGP key pair, with the private key on my laptop
- Generated a paper key that I could use to authenticate the Keybase client on more devices
- Verified ownership of this key pair by posting to public websites

All of these are connected as shown below[^4]

<figure>
    <img data-action="zoom" src="/images/keybase-io/keybase-graph.png" style="width:100%;"></img>
    <figcaption>Keybase constructs this Merkle tree for you, showing all your keys and claimed accounts. As more keys and devices are provisioned, the graph grows and becomes more complex. Notice that I added my second laptop (Nishant-Home-MBP) using my paper key (shove scrap).</figcaption>
</figure>

Now, I'm ready to send and receive verified encrypted messages! It's possible to use the client to create encrypted messages for a Keybase user (or even a non-user if you have their public key). I'll send a message to [Riyaz](https://keybase.io/riyazdf), who originally invited me to the site.

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
Now I can send the message using any email client, and only Riyaz would be able to read it. I hear that soon, it'll also be possible to use Keybase to send the message. Keybase automatically managed the retrieval of his public key, verified social proofs etc. If anything had changed since I last tracked him, I'd get a meaningful error message -- very simple and non-complicated! I know Riyaz on Twitter and Github, hence trust his public key. What's even cooler is I could have used his Twitter handle to do the same (it's the same as the Keybase handle in this case, but it could have been different), since it's connected to the PGP key. So basically

```
$ keybase pgp encrypt riyazdf@twitter -s -m "Hey it's me again."
```
This is really cool, because I'm essentially sending someone an encrypted message just using their Twitter handle!

### My Impression
The first thing that struck me about Keybase is great design. They've made the process of interacting with it extremely transparent and simple, which is brilliant for users who aren't experts. The flexibility of being able to use a command line client is especially appreciated. For those who'd like to be even more careful, it's possible to completely bypass the need for the client, and use command line scripts instead (which the website helps you construct). Note that you could also use the website for decryption and signing, if you chose to upload your private key.

Security and encryption are difficult areas, and especially relevant in modern times. To make it available to everybody, Keybase have made tradeoffs between usability and security that are particularly neat. I suppose they will have to continue to strike that balance, and I'm really excited to see what they do in the future.

People, especially those already used to encryption might complain that Keybase is not perfect -- and it isn't. But using social proofs is a powerful idea, and besides, you can always use Keybase the old fashioned way.

### What Can Go Wrong?
The fundamental idea is that you are signing proofs of your (public key) identity, and hosting them on other websites that **you** own. But any of these websites (including Keybase) can be compromised, so how do you build security and trust on top of systems that are fundamentally "hackable"? The first of defense is that you just try to spread your identity across as many systems as possible, which makes it more robust overall.

#### What if my Twitter account is compromised?
It's possible to revoke a social proof from the Keybase site, and everybody will be able to see that you did so. What happens if all your social accounts are compromised, and need to be revoked? Well then your public key just became less trustworthy, and you already have other equally big (if not bigger) problems.

#### What if my Keybase account is compromised?
You can delete the proofs on the other websites and desert the Keybase account, leaving the intruder with an untrustworthy public key. You should be able to generate new keys, create a new account, and establish identity again. If you uploaded your private key to Keybase, you might be in trouble (don't do it!). This is especially important since the site doesn't support 2-Factor Authentication yet (shocking huh?), and you don't want your private keys protected only by a passphrase.

The Keybase server could also be compromised leading to undesirable outcomes, but there's a better discussion of that [here](https://keybase.io/docs/server_security).

#### Online security is still your responsibility
Keybase is a trusted store for your public keys, but won't make your online presence any more secure. For instance, your password reset email address is likely a single point of failure. Whoever gets access to your email account can hypothetically reset all other accounts and take control, which really is a disaster.

#### Can you protect your private keys?
So far, everything has revolved around being able to protect your private key, but that's another challenge in itself. Do other people use your laptop? Do you carelessly move your keys around? If your private key is compromised though, it's still possible to generate a new pair and provide new social proofs, but all previously encrypted public messages continue to be at risk.

Eventually for most users, it will come down to a tradeoff between convenience and strict security. Some will go old-school and not trust Keybase at all, others will trust fully and upload their private key too (don't!). Several new questions will come up in time. In particular, I'm interested to see how the law catches up with encryption being free and accessible to everyone.

In conclusion, I will say that I'm expecting good things from Keybase and will closely follow the company's progress. It's almost surprising that nobody implemented this idea sooner, although many good ideas appear that way in hindsight. Whether Keybase can stand the test of time, we shall see.

### Some Relevant Links
I've deliberately left out a lot of details from this post to make it more accessible. If you'd like to read further, here's a set of links I pulled up (not exhaustive):

- [Difference between PGP and GPG](http://askubuntu.com/questions/186805/difference-between-pgp-and-gpg)
- [RFC 4880 (OpenPGP Message Format)](https://tools.ietf.org/html/rfc4880)
- [Keybase Server Security](https://keybase.io/docs/server_security)
- [Keybase's New Key Model](https://keybase.io/blog/keybase-new-key-model)
- [Keybase command line client (on Github)](https://github.com/keybase/client)
- [Web of Trust](https://en.wikipedia.org/wiki/Web_of_trust)
- [What is Keybase in layman terms](https://www.quora.com/What-is-Keybase-in-laymans-terms)
- [PGP Web of Trust: Core Concepts Behind Trusted Communication](https://www.linux.com/learn/pgp-web-trust-core-concepts-behind-trusted-communication)
- [Can I use a private key as a public key and vice versa?](http://security.stackexchange.com/questions/9957/can-i-use-a-private-key-as-a-public-key-and-vice-versa)
- [Problems with Keybase](https://anarc.at/blog/2016-03-10-keybase/)
- [PGP message format problems](https://saltpack.org/pgp-message-format-problems)

Please feel free to suggest more links, or updates to the post! Also thanks to Riyaz for proofreading!

[^1]: This is what is known as asymmetric-key encryption, because there are two different keys that have different roles. There's also symmetric-key encryption, where both parties share one (secret) key, and the same key is used to encrypt and decrypt messages. Symmetric-key encryption is generally faster, but the challenge is sharing the key securely.
[^2]: Tamper-evident means that if the message was tampered with along the way, it would be clear because it wouldn't be possible to decrypt it using the matching public or private key.
[^3]: Don't do it! There are several concerns, implications, and reasons around why one may want to do it (or not). [This thread](https://github.com/keybase/keybase-issues/issues/160) might be helpful.
[^4]: This graph, called a Merkle tree or hash tree is a tree in which every non-leaf node is labelled with the hash of the labels or values (in case of leaves) of its child nodes. Hash trees are useful because they allow efficient and secure verification of the contents of large data structures. The Keybase graph has bidirectional edges though, so it implements such checking in both directions.
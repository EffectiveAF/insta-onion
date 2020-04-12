# insta-onion

Create a Tor Onion service in 20 seconds.


## Quickstart

Run these commands:

    wget https://raw.githubusercontent.com/EffectiveAF/insta-onion/master/insta-onion.sh
    cat insta-onion.sh  # just to make sure GitHub isn't serving you something different
    sudo bash insta-onion.sh <onion_service_name> <local_http_port_your_app_is_listening_on>

Example:

    wget https://raw.githubusercontent.com/EffectiveAF/insta-onion/master/insta-onion.sh
    sudo bash insta-onion.sh leapchat 8082

to create a new onion service in `/var/lib/tor/leapchat` whose Tor
traffic is proxied through to `127.0.0.1:8082` .  That's it! :tada:


## Compatibility

Works on Debian and Ubuntu.  Tested as root and non-root users on:

- Debian 10.3 x86_64
- Debian 9.12 x86_64
- Ubuntu 19.10 x86_64
- Ubuntu 18.04.3 LTS x86_64
- Ubuntu 16.04.6 LTS x86_64
- Ubuntu 16.04.6 LTS x86 (32-bit)


## License

[The Hippocratic License 2.1](https://firstdonoharm.dev/), which says,
approximately: you can do pretty much whatever you want with this code
_except_ violate human rights as defined by the UN Universal
Declaration of Human Rights.  See [LICENSE.md](https://github.com/EffectiveAF/insta-onion/blob/master/LICENSE.md)
for details.

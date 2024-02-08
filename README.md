# Wrapper for cascdr

This project wraps [cascdr](https://github.com/cascdr/cascdr-vendor
) for StartOS. CASCDR is a user interface to publish L402 services and earn sats for them.

## Dependencies

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [yq](https://mikefarah.gitbook.io/yq)
- [deno](https://deno.land/)
- [make](https://www.gnu.org/software/make/)
- [start-sdk](https://github.com/Start9Labs/start-os/tree/sdk/backend)

## Build environment

Before building the CASCDR package, your build environment must be setup for building StartOS services. Instructions for setting up the proper build environment can be found in the [Developer Docs](https://docs.start9.com/latest/developer-docs/packaging).

## Cloning

Clone the project locally. Note the submodule link to the original project(s). 

```
git clone git@github.com:Start9Labs/cascdr-wrapper.git
cd cascdr-wrapper
git submodule update --init
cd cascdr-vendor
npm install --omit=dev
```

## Building

To build the **cascdr** service as a universal package, run the following command:

```
make
```

Alternatively the package can be built for individual architectures by specifying the architecture as follows:

```
make x86
```

or

```
make arm
```

## Installing (on StartOS)

Run the following commands to determine successful install:
> :information_source: Change server-name.local to your Start9 server address

```
start-cli auth login
#Enter your StartOS password
start-cli --host https://server-name.local package install cascdr.s9pk
```
**Tip:** You can also install the cascdr.s9pk using **Sideload Service** under the **StartOS > SETTINGS** section.

## Verify Install

Go to your StartOS Services page, select **cascdr**, configure and start the service.

**Done!** 

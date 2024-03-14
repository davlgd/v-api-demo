# V API on Clever Cloud

This is a simple API server built with [V](https://vlang.io/). You'll need a [Clever Cloud account](https://console.clever-cloud.com/) and [Clever Tools](https://github.com/CleverCloud/clever-tools).

## Setup Clever Tools

```bash
npm i -g clever-tools
clever login
```

## Create the Clever Cloud application

We use the Node.js runtime, as it allows us to use custom server and build commands (through `package.json` start script). We compile the V code during the build phase with the [scripts/build.sh](scripts/build.sh) script. The resulting binary is put in the build archive, used during restart, through `CC_OVERRIDE_BUILDCACHE` [environment variable](.env).

```bash
git clone https://github.com/davlgd/v-api-demo
cd v-api-demo
clever create -t node
clever env import < .env
```

## Git push

```bash
git add . && git commit -m "Initial commit"
clever deploy
clever open
```

Then you can test the API through its routes, from a browser or with `curl`:

- `/`
- `/json`
- `/jsonstring`
- `/password`
- `/password/42`
- `/password?length=84`

The server will also send a standard response to any other route.
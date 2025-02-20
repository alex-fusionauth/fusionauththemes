# FusionAuth Themes

> Prerequisites: requires Node 22.6.0 or higher.

## Setup

You can run `pnpm fa:setup` then select 'Setup' to setup your FusionAuth instance.

## Download

<!-- TODO: Download by looking at selected theme folder inside of setup file. -->
> Note: If you are on a newer version or upgrade your FusionAuth Instance, make sure you either download the theme manually or update all the required messages.

```sh
cd <theme-directory>
npx fusionauth theme:download <theme-id> -k <apikey> -h <host> -o <tpl-directory>
```

Example:
```sh
npx fusionauth theme:download e753828b-b475-44f3-8727-39749c2f36e3 -k this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works -h http://localhost:9011 -o ./iron-pixel/tpl
```

## Upload

<!-- TODO: Upload by looking at selected theme folder. -->

```sh
cd <theme-directory>
npx fusionauth theme:upload <theme-id> -k <apikey> -h <host> -i <tpl-directory>
```

Example:
```sh
npx fusionauth theme:upload e753828b-b475-44f3-8727-39749c2f36e3 -k this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works -h http://localhost:9011 -i ./iron-pixel/tpl
```

## Watching Changes and Rebuilding Themes

> More details: https://github.com/FusionAuth/fusionauth-node-cli
> Make sure you update to the CORRECT theme directory!!!
> Note: You need to replace `<themeid>`, `<apikey>`, `<host>` and `<theme-name>` with your own values.

This will require two steps, one for building using Tailwind and the other for uploading to FusionAuth.

### Building CSS from Tailwind
> See more: https://fusionauth.io/docs/customize/look-and-feel/tailwind

Run the below command to watch for changes and rebuild the theme: 
```sh
npx @tailwindcss/cli -i ./<theme-name>/input.css -o ./<theme-name>/tpl/stylesheet.css --watch
```

Example:
```sh
npx @tailwindcss/cli -i ./iron-pixel/input.css -o ./iron-pixel/tpl/stylesheet.css --watch
```

### Uploading to FusionAuth

Run this command in another terminal to automatically update the theme within FusionAuth Instance:
```sh
npx fusionauth theme:watch <themeid> -k <apikey> -h <host> -i ./<theme-name>/tpl/
```

Example:
```sh
npx fusionauth theme:watch e753828b-b475-44f3-8727-39749c2f36e3 -k this_really_should_be_a_long_random_alphanumeric_value_but_this_still_works -h http://localhost:9011 -i ./iron-pixel/tpl/
```

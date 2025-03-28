[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
  [/@helpers.head]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message("passwordless-login")]
      [#setting url_escaping_charset='UTF-8']
      <div class="z-10 p-8 mt-14 max-w-full bg-white rounded-3xl shadow-lg w-[560px] max-md:px-5 max-md:mt-10">
        <div class="flex flex-col w-full text-left max-md:max-w-full">
          <h1 class="text-2xl font-sans font-medium tracking-tight leading-none text-[#1B2D7E] max-md:max-w-full">
            Sign in to Taco's Rewards
          </h1>

        </div>
        <main class="mt-7 w-full max-md:max-w-full">   
          <form action="${request.contextPath}/oauth2/passwordless" method="POST">
            [@helpers.oauthHiddenFields/]
            <div class="mt-6 w-full text-sm tracking-normal max-md:max-w-full flex flex-col gap-4 md:gap-6">
              <div class="w-full leading-loose max-md:max-w-full">
                <div class="flex flex-col justify-center w-full rounded max-md:max-w-full">
                  <label for="loginId" class="text-[#6473B4]"> Email Address </label>
                  <fieldset class="flex flex-col gap-2 md:gap-4">
                    [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message("loginId")  required=true/]
                    [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
                  </fieldset>
                </div>
              </div>

            [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false"]
            [/@helpers.input]
            [@helpers.button color="btn btn-primary w-full" text=theme.message('send')/]
            <p class="flex justify-end">[@helpers.link url="/oauth2/authorize"]${theme.message('return-to-login')}[/@helpers.link]</p>
          </form>
        </main> 
      </div>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]

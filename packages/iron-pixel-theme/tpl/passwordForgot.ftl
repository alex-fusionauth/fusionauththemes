[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    [#-- Custom <head> code goes here --]
  [/@helpers.head]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message('forgot-password-title')]
      <form action="${request.contextPath}/password/forgot" method="POST" class="full">
        [@helpers.oauthHiddenFields/]

        <p>
          ${theme.message('forgot-password')}
        </p>
        <fieldset class="mt-4 space-y-2">
          [@helpers.input type="text" name="email" id="email" autocapitalize="none" autofocus=true autocomplete="on" autocorrect="off" placeholder=theme.message('email') leftAddon="user" required=true/]
          [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
        </fieldset>
        <div class="mt-4">
          [@helpers.button color="btn-neutral" text=theme.message('submit')/]
          <p class="mt-2">[@helpers.link url="/oauth2/authorize"]${theme.message('return-to-login')}[/@helpers.link]</p>
        </div>
      </form>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
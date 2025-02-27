[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="bootstrapWebauthnEnabled" type="boolean" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="federatedCSRFToken" type="java.lang.String" --]
[#-- @ftlvariable name="hasDomainBasedIdentityProviders" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="idpRedirectState" type="java.lang.String" --]
[#-- @ftlvariable name="loginId" type="java.lang.String" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordlessEnabled" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="rememberDevice" type="boolean" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="showPasswordField" type="boolean" --]
[#-- @ftlvariable name="showWebAuthnReauthLink" type="boolean" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    <script src="${request.contextPath}/js/jstz-min-1.0.6.js"></script>
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    <script src="${request.contextPath}/js/oauth2/Authorize.js?version=${version}"></script>
    <script src="${request.contextPath}/js/identityProvider/InProgress.js?version=${version}"></script>
    [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
    <script>
      Prime.Document.onReady(function() {
        [#-- This object handles guessing the timezone, filling in the device id of the user, and check for WebAuthn re-authentication support --]
        new FusionAuth.OAuth2.Authorize();
      });
    </script>
  [/@helpers.head]
  [@helpers.body]

    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

      
    [@helpers.main login=true]     
      <div class="z-10 p-8 mt-14 max-w-full bg-white rounded-3xl shadow-lg w-[560px] max-md:px-5 max-md:mt-10">
        <div class="flex flex-col w-full text-center max-md:max-w-full items-center">
          <h1 class="text-2xl font-medium tracking-tight leading-none text-sky-950 max-md:max-w-full">
            Secure Login
          </h1>
          <p class="mt-3 text-lg tracking-tight leading-none max-md:max-w-full text-[19384c]">
            Turning hard earned dollars into change®
          </p>
        </div>
        <main class="mt-7 w-full max-md:max-w-full">   
          <form action="${request.contextPath}/oauth2/authorize" method="POST">
            <div class="mt-6 w-full text-sm tracking-normal max-md:max-w-full flex flex-col gap-2">
              <div class="w-full leading-loose text-gray-400 max-md:max-w-full">
                <div class="flex flex-col justify-center w-full rounded max-md:max-w-full">
                  <fieldset class="flex flex-col gap-2 md:gap-4">

                    [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message("loginId") disabled=(showPasswordField && hasDomainBasedIdentityProviders) /]
                    [#if showPasswordField]
                      [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message("password") /]
                      [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
                      [#if errorMessages?size > 0]
                        [#list errorMessages as m]
                          <div class="text-red-500">${m}</div>
                        [/#list]
                      [/#if]
                    [/#if]
                  </fieldset>
                </div>
              </div>
              <div class="flex flex-col gap-2">
              [#if showPasswordField]
              <div class="flex gap-2">
                <div class="flex flex-1 gap-2 justify-between self-stretch my-auto leading-loose">
                  <label htmlFor="remember-me" class="self-stretch my-auto">
                  [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false" class="checkbox checkbox-primary"]
                    [#t/]
                  [/@helpers.input]
                  </label>
                  [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
                </div>
              </div>
              [#else]
                [@helpers.button icon="arrow-right" color="btn btn-primary" text=theme.message("next")/]
              [/#if]
            </div>
                  <button type="submit" class="btn btn-primary">
                    Log In
                  </button>

                [@helpers.oauthHiddenFields/]
                [@helpers.hidden name="showPasswordField"/]
                [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]
                [#if showPasswordField && hasDomainBasedIdentityProviders]
                  [@helpers.hidden name="loginId"/]
                [/#if]

            [#if showWebAuthnReauthLink]
              [@helpers.link url="${request.contextPath}/oauth2/webauthn-reauth"] ${theme.message("return-to-webauthn-reauth")} [/@helpers.link]
            [/#if]
              [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled bootstrapWebauthnEnabled=bootstrapWebauthnEnabled idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
          </form>
        </main>
      </div>
      <div>
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message("sign-in-as-different-user")}[/@helpers.link]
        [/#if]
      </div>
      <div class="z-10 mt-14 text-base font-medium tracking-normal text-primary-content max-md:mt-10">
        <span class="text-primary-content">${theme.message("dont-have-an-account")} </span>
        <span class="text-primary-content">
        [@helpers.link url="${request.contextPath}/oauth2/register"]${theme.message("create-an-account")}[/@helpers.link]
        </span>
      </div>
    [/@helpers.main]
    [@helpers.footer]
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]

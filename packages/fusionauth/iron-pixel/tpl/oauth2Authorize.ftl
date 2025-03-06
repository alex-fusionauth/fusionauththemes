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
          <div class="flex gap-2 md:gap-4">
            <div class="flex gap-2 items-center my-auto leading-loose">
              <label htmlFor="remember-me" class="my-auto">
              [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false" class="checkbox checkbox-primary"]
                [#t/]
              [/@helpers.input]
              </label>
            </div>

              <button type="submit" class="btn btn-primary flex-1">
                Log In
              </button>
            </div>



        <div class="flex gap-10 justify-between items-start py-5 mt-6 w-full text-sm tracking-normal leading-loose text-white border-t border-b border-white border-opacity-10 max-md:max-w-full">
        <div class="flex justify-between w-full">
        
        <div>
            [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
          [#else]
            [@helpers.button icon="arrow-right" color="btn btn-primary" text=theme.message("next")/]
          [/#if]
          </div>

          <div>
            [#if showPasswordField && hasDomainBasedIdentityProviders]
              [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message("sign-in-as-different-user")}[/@helpers.link]
            [/#if]
          [#if application.registrationConfiguration.enabled]
            <div class="flex text-right gap-2 md:gap-4">
              ${theme.message("dont-have-an-account")}
              [@helpers.link url="${request.contextPath}/oauth2/register"]${theme.message("create-an-account")}[/@helpers.link]
            </div>
          [/#if]
          </div>

      </div>
          </div>
        </div>
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
    [/@helpers.main]
    [@helpers.footer]
      [#-- Custom footer code goes here --]
 
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]

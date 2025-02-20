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

      <section class="h-screen w-screen flex items-center justify-center p-0 sm:p-12">
        <div class="grid grid-cols-1 lg:grid-cols-2 max-h-full max-w-full aspect-[2/1]">

        [#-- Photo --]
        <div class="hidden lg:flex relative flex-col items-center justify-center px-8 py-8 w-full">
          <img
            loading="lazy"
            src="https://res.cloudinary.com/djox1exln/image/upload/v1739206563/background-left_hbtcsz.jpg"
            class="object-cover absolute inset-0 size-full object-center"
            alt="Background"
          />
          <div class="flex overflow-hidden relative flex-col pb-3 pl-2.5 w-full shadow-sm min-h-[400px] max-md:max-w-full">
            <img
              loading="lazy"
              src="https://res.cloudinary.com/djox1exln/image/upload/v1739207333/game-1_hz8dfv.png"
              class="object-cover absolute inset-0 size-full"
              alt="Game Overlay"
            />
            <div class="flex relative flex-wrap gap-5 justify-between max-md:max-w-full">
              <div
                class="object-contain shrink-0 self-start mt-3 w-5 aspect-[1.25]"
                alt="Icon"
              >
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 17" fill="currentColor"><g opacity="1"><path d="M2.35789 3.86842L9.93684 7.23684V16.5L0 11.4474L2.35789 3.86842Z" fill="currentColor"></path><path d="M17.5158 3.86842L9.93684 7.23684V16.5L19.8737 11.4474L17.5158 3.86842Z" fill="currentColor"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M9.93684 1.97445L16.1684 4.74404V7.91053H3.70526V4.74404L9.93684 1.97445ZM2.35789 3.86842L9.93684 0.5L17.5158 3.86842V9.2579H2.35789V3.86842Z" fill="currentColor"></path></g></svg>
              </div>
              <img
                loading="lazy"
                src="https://cdn.builder.io/api/v1/image/assets/TEMP/3c4269182d3775c272e2d79990d5c1a7dfc4ba495ffbc9ea6e55e54d04364a18?placeholderIfAbsent=true"
                class="object-contain shrink-0 max-w-full aspect-[1.4] w-[175px]"
                alt="Logo"
              />
            </div>
            <div class="flex relative flex-col justify-center px-3 py-3 mt-60 bg-black bg-opacity-60 min-h-7">
              <div class="w-full max-md:max-w-full">
                <div class="flex relative flex-col items-start min-h-[5px] max-md:pr-5 max-md:max-w-full">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/448e5ea2f6241981bf5c75a9c7628812968e05757b3183ac1f5b50fc28151759?placeholderIfAbsent=true"
                    class="object-cover absolute inset-0 size-full"
                    alt="Progress bar background"
                  />
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/d197cb55e6e5e5e43d569214b6a36438645a92c19d4ff954602f61e3e0e24af0?placeholderIfAbsent=true"
                    class="object-contain max-w-full aspect-[45.45] w-[231px]"
                    alt="Progress bar"
                  />
                </div>
              </div>
            </div>
          </div>
          <div class="grid grid-cols-3 relative gap-2 md:gap-6 items-center mt-6 w-full max-md:max-w-full">
            <img
              loading="lazy"
              src="https://res.cloudinary.com/djox1exln/image/upload/v1739207333/game-1_hz8dfv.png"
              class="object-cover flex-1 shrink self-stretch my-auto rounded aspect-video basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)]"
              alt="Game 1"
            />
            <img
              loading="lazy"
              src="https://res.cloudinary.com/djox1exln/image/upload/v1739207965/game-2_rboby0.png"
              class="object-cover flex-1 shrink self-stretch my-auto rounded aspect-video basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)]"
              alt="Game 2"
            />
            <img
              loading="lazy"
              src="https://res.cloudinary.com/djox1exln/image/upload/v1739207966/game-3_nmuhh2.png"
              class="object-cover flex-1 shrink self-stretch my-auto rounded aspect-video basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)]"
              alt="Game 3"
            />
          </div>
        </div>
        [#-- LOGIN --]
        <div class="flex relative flex-col px-8 py-8 w-full">

              [#if devicePendingIdPLink?? || pendingIdPLink??]
                <p class="mt-0">
                [#if devicePendingIdPLink?? && pendingIdPLink??]
                  ${theme.message('pending-links-login-to-complete', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
                [#elseif devicePendingIdPLink??]
                  ${theme.message('pending-link-login-to-complete', devicePendingIdPLink.identityProviderName)}
                [#else]
                  ${theme.message('pending-link-login-to-complete', pendingIdPLink.identityProviderName)}
                [/#if]
                
                [#if pendingIdPLink??]
                  [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message("login-cancel-link")}[/@helpers.link]
                [/#if]
                </p>
              [/#if]

          <img
            loading="lazy"
            src="https://res.cloudinary.com/djox1exln/image/upload/v1739199486/cbfdbbbe1c08984c203d09fe5e60d1df_fhm7lg.jpg"
            class="object-cover absolute inset-0 size-full"
            alt="Background"
          />
              [@helpers.main title=theme.message("Iron Pixel")]        
          <div class="relative flex-1 mt-14 w-full max-md:mt-10 max-md:max-w-full">
            <div class="flex items-start w-full text-xl tracking-wide leading-snug border-b border-white border-opacity-30 max-md:max-w-full">
              <div class="flex-1 shrink px-4 pb-4 font-semibold text-white border-b-4 border-teal-500 min-h-11">
                Log In
              </div>
              <div class="flex-1 shrink px-4 pb-4 min-h-11 text-white text-opacity-60">
              [@helpers.link url="${request.contextPath}/oauth2/register"]
                Sign Up
                [/@helpers.link]
              </div>
            </div>
            <div class="flex flex-col justify-center mt-6 w-full max-md:max-w-full">
              <div class="text-lg leading-none text-white max-md:max-w-full">
                Log in to your Iron Pixel account.
              </div>
              <div class="mt-3 text-sm tracking-normal leading-6 text-white text-opacity-80 max-md:max-w-full">
                Your account connects you to all things Iron Pixel. Log in with
                your existing credentials to access your purchases and account
                settings.
              </div>
            </div>

              <form action="${request.contextPath}/oauth2/authorize" method="POST">


            <div class="mt-6 w-full text-sm tracking-normal max-md:max-w-full">
              <div class="w-full leading-loose text-gray-400 max-md:max-w-full">
                <div class="flex flex-col justify-center w-full rounded max-md:max-w-full">
                  <fieldset class="flex flex-col gap-2 md:gap-4">
                    <div>
                    <label for="loginId">Email Address</label>
                    [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message("loginId") disabled=(showPasswordField && hasDomainBasedIdentityProviders) class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full p-2" /]
                    </div>
                    [#if showPasswordField]
                    <div>
                      <label for="password">Password</label>
                      [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message("password") class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full p-2${(errorMessages?size > 0)?then(' outline-red-500 outline-2', '')}" /]
                      [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
                      [#if errorMessages?size > 0]
                        [#list errorMessages as m]
                          <div class="text-red-500">${m}</div>
                        [/#list]
                      [/#if]
                    </div>
                    [/#if]
                  </fieldset>
                </div>
              </div>
              <div class="flex flex-col gap-2">
              [#if showPasswordField]
              <div class="flex gap-2">
                <div class="flex flex-1 gap-2 items-center self-stretch my-auto leading-loose text-slate-50">
                  <label htmlFor="remember-me" class="self-stretch my-auto">
                  [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false" class="checkbox checkbox-primary"]
                    [#t/]
                  [/@helpers.input]
                  </label>
                </div>

                  <button type="submit" class="flex-1 shrink gap-2.5 self-stretch px-5 py-4 my-auto leading-none text-center rounded bg-teal-950 text-white text-opacity-30">
                    Log In
                  </button>
                </div>



            <div class="flex gap-10 justify-between items-start py-5 mt-6 w-full text-sm tracking-normal leading-loose text-white border-t border-b border-white border-opacity-10 max-md:max-w-full">
            <div class="flex justify-between w-full">
            
            <div>
                [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
              [#else]
                [@helpers.button icon="arrow-right" text=theme.message("next")/]
              [/#if]
              </div>

              <div>
                [#if showPasswordField && hasDomainBasedIdentityProviders]
                  [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message("sign-in-as-different-user")}[/@helpers.link]
                [/#if]
              [#if application.registrationConfiguration.enabled]
                <div class="flex flex-col text-right">
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
              </form>


            [#if showWebAuthnReauthLink]
              [@helpers.link url="${request.contextPath}/oauth2/webauthn-reauth"] ${theme.message("return-to-webauthn-reauth")} [/@helpers.link]
            [/#if]
              [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled bootstrapWebauthnEnabled=bootstrapWebauthnEnabled idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]

      [/@helpers.main]
          </div>
        </div>
      </section>
    [@helpers.footer]
      [#-- Custom footer code goes here --]
        </div>
      </section>
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]

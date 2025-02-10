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
    <section className="flex gap-5 max-md:flex-col">
      <div className="w-6/12 max-md:ml-0 max-md:w-full">
        <div className="flex overflow-hidden relative flex-col justify-center px-8 py-44 w-full min-h-[900px] max-md:px-5 max-md:py-24 max-md:max-w-full">
          [#-- <img          loading="lazy"             className="object-cover absolute inset-0 size-full"     alt="Background"/> 
          --]
          <div className="flex overflow-hidden relative flex-col pb-3 pl-2.5 w-full shadow-sm min-h-[400px] max-md:max-w-full">
            <img
              loading="lazy"
              srcSet="https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=100 100w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=200 200w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=400 400w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=800 800w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=1200 1200w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=1600 1600w, https://cdn.builder.io/api/v1/image/assets/TEMP/47b5b57536edbe236088943d370478e5a27f32cb0224b9c7b67fb6a6d62415c0?placeholderIfAbsent=true&width=2000 2000w"
              className="object-cover absolute inset-0 size-full"
              alt="Overlay"
            />
            <div className="flex relative flex-wrap gap-5 justify-between max-md:max-w-full">
              <img
                loading="lazy"
                src="https://cdn.builder.io/api/v1/image/assets/TEMP/b4ce2344af4b8c59ad42eab4cbffdc8e6e2e3e5909a6f3e41d3c573c58c15e79?placeholderIfAbsent=true"
                className="object-contain shrink-0 self-start mt-3 w-5 aspect-[1.25]"
                alt="Icon"
              />
              <img
                loading="lazy"
                src="https://cdn.builder.io/api/v1/image/assets/TEMP/3c4269182d3775c272e2d79990d5c1a7dfc4ba495ffbc9ea6e55e54d04364a18?placeholderIfAbsent=true"
                className="object-contain shrink-0 max-w-full aspect-[1.4] w-[175px]"
                alt="Logo"
              />
            </div>
            <div className="flex relative flex-col justify-center px-3 py-3 mt-60 bg-black bg-opacity-60 min-h-7 max-md:mt-10 max-md:mr-2.5 max-md:max-w-full">
              <div className="w-full max-md:max-w-full">
                <div className="flex relative flex-col items-start min-h-[5px] max-md:pr-5 max-md:max-w-full">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/448e5ea2f6241981bf5c75a9c7628812968e05757b3183ac1f5b50fc28151759?placeholderIfAbsent=true"
                    className="object-cover absolute inset-0 size-full"
                    alt="Progress bar background"
                  />
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/d197cb55e6e5e5e43d569214b6a36438645a92c19d4ff954602f61e3e0e24af0?placeholderIfAbsent=true"
                    className="object-contain max-w-full aspect-[45.45] w-[231px]"
                    alt="Progress bar"
                  />
                </div>
              </div>
            </div>
          </div>
          <div className="flex relative flex-wrap gap-6 items-center mt-6 w-full max-md:max-w-full">
            <img
              loading="lazy"
              srcSet="https://cdn.builder.io/api/v1/image/assets/TEMP/3ad20ea3df771e313f4be038b88f739285feee4122161e8de95bd0fa7bb181d5?placeholderIfAbsent=true&width=100 100w, https://cdn.builder.io/api/v1/image/assets/TEMP/3ad20ea3df771e313f4be038b88f739285feee4122161e8de95bd0fa7bb181d5?placeholderIfAbsent=true&width=200 200w, https://cdn.builder.io/api/v1/image/assets/TEMP/3ad20ea3df771e313f4be038b88f739285feee4122161e8de95bd0fa7bb181d5?placeholderIfAbsent=true&width=400 400w, https://cdn.builder.io/api/v1/image/assets/TEMP/3ad20ea3df771e313f4be038b88f739285feee4122161e8de95bd0fa7bb181d5?placeholderIfAbsent=true&width=800 800w"
              className="object-contain flex-1 shrink self-stretch my-auto rounded aspect-[1.56] basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)] w-[195px]"
              alt="Thumbnail 1"
            />
            <img
              loading="lazy"
              srcSet="https://cdn.builder.io/api/v1/image/assets/TEMP/200b14d9ff1ec290ff51e65784c59089c1dc0e2eecf7d018ffda1b71fbc48051?placeholderIfAbsent=true&width=100 100w, https://cdn.builder.io/api/v1/image/assets/TEMP/200b14d9ff1ec290ff51e65784c59089c1dc0e2eecf7d018ffda1b71fbc48051?placeholderIfAbsent=true&width=200 200w, https://cdn.builder.io/api/v1/image/assets/TEMP/200b14d9ff1ec290ff51e65784c59089c1dc0e2eecf7d018ffda1b71fbc48051?placeholderIfAbsent=true&width=400 400w, https://cdn.builder.io/api/v1/image/assets/TEMP/200b14d9ff1ec290ff51e65784c59089c1dc0e2eecf7d018ffda1b71fbc48051?placeholderIfAbsent=true&width=800 800w"
              className="object-contain flex-1 shrink self-stretch my-auto rounded aspect-[1.57] basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)] w-[196px]"
              alt="Thumbnail 2"
            />
            <img
              loading="lazy"
              srcSet="https://cdn.builder.io/api/v1/image/assets/TEMP/5ebb2d2b40d07b15d3bb693563a8e2af5202ed57234546b734dd26bb09284f10?placeholderIfAbsent=true&width=100 100w, https://cdn.builder.io/api/v1/image/assets/TEMP/5ebb2d2b40d07b15d3bb693563a8e2af5202ed57234546b734dd26bb09284f10?placeholderIfAbsent=true&width=200 200w, https://cdn.builder.io/api/v1/image/assets/TEMP/5ebb2d2b40d07b15d3bb693563a8e2af5202ed57234546b734dd26bb09284f10?placeholderIfAbsent=true&width=400 400w, https://cdn.builder.io/api/v1/image/assets/TEMP/5ebb2d2b40d07b15d3bb693563a8e2af5202ed57234546b734dd26bb09284f10?placeholderIfAbsent=true&width=800 800w"
              className="object-contain flex-1 shrink self-stretch my-auto rounded aspect-[1.56] basis-0 shadow-[0px_4px_4px_rgba(0,0,0,0.28)] w-[195px]"
              alt="Thumbnail 3"
            />
          </div>
      </div>
    <div className="ml-5 w-6/12 max-md:ml-0 max-md:w-full">
      <div className="flex overflow-hidden relative flex-col justify-center px-28 py-8 w-full min-h-[900px] max-md:px-5 max-md:max-w-full">
        {/* <img
          loading="lazy"
          srcSet="https://cdn.builder.io/api/v1/image/assets/TEMP/7c7299e1b63dcfc79eccacc79bccfcdce6679fd38d53f1568fce54c510fae2cd?placeholderIfAbsent=true&width=100 100w, https://cdn.builder.io/api/v1/image/assets/TEMP/7c7299e1b63dcfc79eccacc79bccfcdce6679fd38d53f1568fce54c510fae2cd?placeholderIfAbsent=true&width=200 200w, https://cdn.builder.io/api/v1/image/assets/TEMP/7c7299e1b63dcfc79eccacc79bccfcdce6679fd38d53f1568fce54c510fae2cd?placeholderIfAbsent=true&width=400 400w, https://cdn.builder.io/api/v1/image/assets/TEMP/7c7299e1b63dcfc79eccacc79bccfcdce6679fd38d53f1568fce54c510fae2cd?placeholderIfAbsent=true&width=800 800w"
          className="object-cover absolute inset-0 size-full"
          alt="Background"
        /> */}
        <img
          loading="lazy"
          src="https://cdn.builder.io/api/v1/image/assets/TEMP/6709b14fc1151efc46817ffb769741bf16d89c1921aaae8c2373d4b117a26b1c?placeholderIfAbsent=true"
          className="object-contain self-center max-w-full aspect-[8.47] w-[273px]"
          alt="Logo"
        />
        <div className="relative flex-1 mt-14 w-full max-md:mt-10 max-md:max-w-full">
          <div className="flex items-start w-full text-xl tracking-wide leading-snug border-b border-white border-opacity-30 max-md:max-w-full">
            <div className="flex-1 shrink px-4 pb-4 font-semibold text-white border-b-4 border-teal-500 min-h-11">
              Log In
            </div>
            <div className="flex-1 shrink px-4 pb-4 min-h-11 text-white text-opacity-60">
              Sign Up
            </div>
          </div>
          <div className="flex flex-col justify-center mt-6 w-full max-md:max-w-full">
            <div className="text-lg leading-none text-white max-md:max-w-full">
              Log in to your Iron Pixel account.
            </div>
            <div className="mt-3 text-sm tracking-normal leading-6 text-white text-opacity-80 max-md:max-w-full">
              Your account connects you to all things Iron Pixel. Log in with
              your existing credentials to access your purchases and account
              settings.
            </div>
          </div>
          <div className="mt-6 w-full text-sm tracking-normal max-md:max-w-full">
            <div className="w-full leading-loose text-gray-400 max-md:max-w-full">
              <div className="flex flex-col justify-center w-full rounded max-md:max-w-full">
                <input
                  type="email"
                  placeholder="Email Address"
                  className="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full"
                />
              </div>
              <div className="flex flex-col justify-center mt-4 w-full whitespace-nowrap rounded bg-cyan-950 max-md:max-w-full">
                <input
                  type="password"
                  placeholder="Password"
                  className="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full"
                />
              </div>
            </div>
            <div className="flex gap-8 items-center mt-4 w-full max-md:max-w-full">
              <div className="flex gap-2 items-center self-stretch my-auto leading-loose text-slate-50">
                <input
                  type="checkbox"
                  className="checkbox checkbox-primary"
                  id="remember-me"
                />
                <label htmlFor="remember-me" className="self-stretch my-auto">
                  Remember Me
                </label>
              </div>
              <button className="flex-1 shrink gap-2.5 self-stretch px-5 py-4 my-auto leading-none text-center rounded bg-teal-950 min-w-60 text-white text-opacity-30">
                Log In
              </button>
            </div>
          </div>
          <div className="flex gap-10 justify-between items-start py-5 mt-6 w-full text-sm tracking-normal leading-loose text-white border-t border-b border-white border-opacity-10 max-md:max-w-full">
            <button className="hover:text-primary">
              Forgot your password?
            </button>
            <div className="font-medium">
              <span className="font-open-sans font-normal">
                Don't have an account?{" "}
              </span>
              <button className="font-open-sans font-normal hover:text-primary">
                Sign Up
              </button>
            </div>
          </div>
          <div className="flex flex-col mt-6 w-full text-white max-md:max-w-full">
            <div className="self-start text-base tracking-wide text-center max-md:max-w-full">
              Or, log in with a game account
            </div>
            <div className="px-20 mt-6 w-full text-sm font-semibold leading-none max-md:px-5 max-md:max-w-full">
              <div className="flex gap-2 items-center w-full text-center whitespace-nowrap">
                <button className="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/8e0e2e25c2d789b1d208ba125c2e30ace387721db9f3cf139caaa4927d080c03?placeholderIfAbsent=true"
                    className="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Steam"
                  />
                  <span>Steam</span>
                </button>
                <button className="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/560644be9c6a1529f87fa0f087880de2c080a55aa9f3a284f99b9bdf3f36a825?placeholderIfAbsent=true"
                    className="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Xbox"
                  />
                  <span>Xbox</span>
                </button>
              </div>
              <div className="flex gap-2 items-center mt-2 w-full">
                <button className="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto text-center whitespace-nowrap rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/edd6ca3a42adf5079b4780496246dfc4364138569baf436ac3d24330d1491b27?placeholderIfAbsent=true"
                    className="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Twitch"
                  />
                  <span>Twitch</span>
                </button>
                <button className="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/825488faa339f626c58e1abe3f7645e34980e8ac1de4ba9c421132efd819a175?placeholderIfAbsent=true"
                    className="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Epic Games"
                  />
                  <span>Epic Games</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    </section>
[#-- 
            [@helpers.main title=theme.message("login")]
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
              --]
[#--
              <form action="${request.contextPath}/oauth2/authorize" method="POST">
                [@helpers.oauthHiddenFields/]
                [@helpers.hidden name="showPasswordField"/]
                [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]
                [#if showPasswordField && hasDomainBasedIdentityProviders]
                  [@helpers.hidden name="loginId"/]
                [/#if]

                <fieldset>
                  [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message("loginId") leftAddon="user" disabled=(showPasswordField && hasDomainBasedIdentityProviders)/]
                  [#if showPasswordField]
                    [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message("password") leftAddon="lock"/]
                    [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
                  [/#if]
                </fieldset>

                  [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false"]
                    <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
                  [/@helpers.input]

                  <div class="form-row">
                    [#if showPasswordField]
                      [@helpers.button icon="key" text=theme.message("submit")/]
                      [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
                    [#else]
                      [@helpers.button icon="arrow-right" text=theme.message("next")/]
                    [/#if]
                  </div>
              </form>
              <div>
                [#if showPasswordField && hasDomainBasedIdentityProviders]
                  [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message("sign-in-as-different-user")}[/@helpers.link]
                [/#if]
              </div>
              [#if application.registrationConfiguration.enabled]
                <div class="form-row push-top">
                  ${theme.message("dont-have-an-account")}
                  [@helpers.link url="${request.contextPath}/oauth2/register"]${theme.message("create-an-account")}[/@helpers.link]
                </div>
              [/#if]

            [#if showWebAuthnReauthLink]
              [@helpers.link url="${request.contextPath}/oauth2/webauthn-reauth"] ${theme.message("return-to-webauthn-reauth")} [/@helpers.link]
            [/#if]
              [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled bootstrapWebauthnEnabled=bootstrapWebauthnEnabled idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
            [/@helpers.main]
--]
    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]

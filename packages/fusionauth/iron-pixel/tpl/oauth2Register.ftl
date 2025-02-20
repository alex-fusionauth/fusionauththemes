[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="collectBirthDate" type="boolean" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="federatedCSRFToken" type="java.lang.String" --]
[#-- @ftlvariable name="fields" type="java.util.List<io.fusionauth.domain.form.FormField>" --]
[#-- @ftlvariable name="hideBirthDate" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="idpRedirectState" type="java.lang.String" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="parentEmailRequired" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="step" type="int" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="totalSteps" type="int" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    <script src="${request.contextPath}/js/identityProvider/InProgress.js?version=${version}"></script>
    [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
    [#if step == totalSteps]
      [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    [/#if]
    <script type="text/javascript">
      document.addEventListener('DOMContentLoaded', () => {
        const uvpaAvailableField = document.querySelector('input[name="userVerifyingPlatformAuthenticatorAvailable"]');
        if (uvpaAvailableField !== null && typeof(PublicKeyCredential) !== 'undefined' && PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable) {
          PublicKeyCredential
            .isUserVerifyingPlatformAuthenticatorAvailable()
            .then(result => uvpaAvailableField.value = result);
        }
      });
    </script>
    [#-- Custom <head> code goes here --]
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
        [#-- Register --]
        <div class="flex relative flex-col px-8 py-8 w-full">
        [#if devicePendingIdPLink?? || pendingIdPLink??]
          <p class="mt-0">
          [#if devicePendingIdPLink?? && pendingIdPLink??]
            ${theme.message('pending-links-register-to-complete', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
          [#elseif devicePendingIdPLink??]
            ${theme.message('pending-link-register-to-complete', devicePendingIdPLink.identityProviderName)}
          [#else]
            ${theme.message('pending-link-register-to-complete', pendingIdPLink.identityProviderName)}
          [/#if]
          [#-- A pending link can be cancled. If we also have a device link in progress, this cannot be canceled. --]
          [#if pendingIdPLink??]
            [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message("register-cancel-link")}[/@helpers.link]
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

      <form action="${request.contextPath}/oauth2/register" method="POST" class="full">
 [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="step"/]
        [@helpers.hidden name="registrationState"/]
        [@helpers.hidden name="parentEmailRequired"/]
        [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]

        [#-- Show the Password Validation Rules if there is a field error for 'user.password' --]
        [#if (fieldMessages?keys?seq_contains("user.password")!false) && passwordValidationRules??]
          [@helpers.passwordRules passwordValidationRules/]
        [/#if]

        [#-- Begin Self Service Custom Registration Form Steps --]
        [#if fields?has_content]
          <fieldset>
            [@helpers.hidden name="collectBirthDate"/]
            [#list fields as field]
              [@helpers.customField field field.key field?is_first?then(true, false) field.key /]
              [#if field.confirm]
                [@helpers.customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
              [/#if]
            [/#list]
            [#-- If this is the last step of the form, optionally show a captcha. --]
            [#if step == totalSteps]
              [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
            [/#if]
          </fieldset>

          [#if step == totalSteps]
            [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false"]
              <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
            [/@helpers.input]
            <div class="form-row">
              [@helpers.button icon="key" text=theme.message('register')/]
            </div>
          [#else]
            <div class="form-row">
              [@helpers.button icon="arrow-right" text=theme.message('next')/]
            </div>
          [/#if]
        [#-- End Custom Self Service Registration Form Steps --]
        [#else]
        [#-- Begin Basic Self Service Registration Form --]
        <fieldset>
          [@helpers.hidden name="collectBirthDate"/]
          [#if !collectBirthDate && (!application.registrationConfiguration.birthDate.enabled || hideBirthDate)]
            [@helpers.hidden name="user.birthDate" dateTimeFormat="yyyy-MM-dd"/]
          [/#if]
          [#if collectBirthDate]
            [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') leftAddon="calendar" class="date-picker" required=true/]
          [#else]
            [#if application.registrationConfiguration.loginIdType == 'email']
              [@helpers.input type="text" name="user.email" id="email" autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('email') leftAddon="user" required=true/]
            [#else]
              [@helpers.input type="text" name="user.username" id="username" autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('username') leftAddon="user" required=true/]
            [/#if]
            [@helpers.input type="password" name="user.password" id="password" autocomplete="new-password" placeholder=theme.message('password') leftAddon="lock" required=true/]
            [#if application.registrationConfiguration.confirmPassword]
              [@helpers.input type="password" name="passwordConfirm" id="passwordConfirm" autocomplete="new-password" placeholder=theme.message('passwordConfirm') leftAddon="lock" required=true/]
            [/#if]
            [#if parentEmailRequired]
              [@helpers.input type="text" name="user.parentEmail" id="parentEmail" placeholder=theme.message('parentEmail') leftAddon="user" required=true/]
            [/#if]
            [#if application.registrationConfiguration.birthDate.enabled ||
            application.registrationConfiguration.firstName.enabled    ||
            application.registrationConfiguration.fullName.enabled     ||
            application.registrationConfiguration.middleName.enabled   ||
            application.registrationConfiguration.lastName.enabled     ||
            application.registrationConfiguration.mobilePhone.enabled  ||
            application.registrationConfiguration.preferredLanguages.enabled ]
              <div class="mt-5 mb-5"></div>
              [#if application.registrationConfiguration.firstName.enabled]
                [@helpers.input type="text" name="user.firstName" id="firstName" placeholder=theme.message('firstName') leftAddon="user" required=application.registrationConfiguration.firstName.required/]
              [/#if]
              [#if application.registrationConfiguration.fullName.enabled]
                [@helpers.input type="text" name="user.fullName" id="fullName" placeholder=theme.message('fullName') leftAddon="user" required=application.registrationConfiguration.fullName.required/]
              [/#if]
              [#if application.registrationConfiguration.middleName.enabled]
                [@helpers.input type="text" name="user.middleName" id="middleName" placeholder=theme.message('middleName') leftAddon="user" required=application.registrationConfiguration.middleName.required/]
              [/#if]
              [#if application.registrationConfiguration.lastName.enabled]
                [@helpers.input type="text" name="user.lastName" id="lastName" placeholder=theme.message('lastName') leftAddon="user" required=application.registrationConfiguration.lastName.required/]
              [/#if]
              [#if application.registrationConfiguration.birthDate.enabled && !hideBirthDate]
                [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') leftAddon="calendar" class="date-picker" required=application.registrationConfiguration.birthDate.required/]
              [/#if]
              [#if application.registrationConfiguration.mobilePhone.enabled]
                [@helpers.input type="text" name="user.mobilePhone" id="mobilePhone" placeholder=theme.message('mobilePhone') leftAddon="phone" required=application.registrationConfiguration.mobilePhone.required/]
              [/#if]
              [#if application.registrationConfiguration.preferredLanguages.enabled]
                [@helpers.locale_select field="" name="user.preferredLanguages" id="preferredLanguages" label=theme.message("preferredLanguage") required=application.registrationConfiguration.preferredLanguages.required /]
              [/#if]
            [/#if]
          [/#if]
          [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
        </fieldset>

        [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message('remember-device') value="true" uncheckedValue="false"]
          <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
        [/@helpers.input]

        <div class="form-row">
          [@helpers.button icon="key" text=theme.message('register')/]
          <p class="mt-2">[@helpers.link url="/oauth2/authorize"]${theme.message('return-to-login')}[/@helpers.link]</p>
        </div>
        [/#if]
        [#-- End Basic Self Service Registration Form --]

        [#-- Begin Self Service Custom Registration Form Step Counter --]
        [#if step > 0]
          <div class="w-100 mt-3" style="display: inline-flex; flex-direction: row; justify-content: space-evenly;">
            <div class="text-right" style="flex-grow: 1;"> ${theme.message('register-step', step, totalSteps)} </div>
          </div>
        [/#if]
        [#-- End Self Service Custom Registration Form Step Counter --]

        [#-- Identity Provider Buttons (if you want to include these, remove the if-statement) --]
        [#if true]
          [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders![] passwordlessEnabled=false bootstrapWebauthnEnabled=false idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
        [/#if]
        [#-- End Identity Provider Buttons --]

      </form>
      [/@helpers.main]
          </div>
        </div>
      </section>

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]

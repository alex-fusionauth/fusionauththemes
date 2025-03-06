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

[#assign protocol = redirect_uri?split("/")[0] /]
[#assign origin = redirect_uri?split("/")[2] /]

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

    [@helpers.main]
      <div class="z-10 p-8 mt-14 max-w-full bg-white rounded-3xl shadow-lg w-[560px] max-md:px-5 max-md:mt-10">
        <div class="flex flex-col w-full text-center max-md:max-w-full items-center">
          <h1 class="text-2xl font-medium tracking-tight leading-none text-[#1B2D7E] max-md:max-w-full">
            Create Your Taco's Rewards Account
          </h1>
        </div>
        <main class="mt-7 w-full max-md:max-w-full">   
          <form action="${request.contextPath}/oauth2/register" method="POST" class="flex flex-col gap-2 md:gap-4">

            [#-- Begin Self Service Custom Registration Form Step Counter --]
            [#if step > 0]
              <div class="flex flex-row">
               [#list 1..totalSteps as aStep]
                  [#if aStep <= step]
                    <div class="relative flex">
                      <svg xmlns="http://www.w3.org/2000/svg" width="28" height="32" viewBox="0 0 28 32" fill="none">
                        <path d="M12.0154 1.13403C13.2452 0.431328 14.7548 0.431328 15.9846 1.13403L25.9846 6.84832C27.2309 7.56049 28 8.88586 28 10.3213V21.6787C28 23.1141 27.2309 24.4395 25.9846 25.1517L15.9846 30.866C14.7548 31.5687 13.2452 31.5687 12.0154 30.866L2.01544 25.1517C0.769144 24.4395 0 23.1141 0 21.6787V10.3213C0 8.88586 0.769144 7.56049 2.01544 6.84832L12.0154 1.13403Z" fill="var(--color-primary)"/>
                      </svg>
                    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-primary-content">${aStep}</div>
                    </div>
                  [#else]
                    <div class="relative flex">
                      <svg xmlns="http://www.w3.org/2000/svg" width="28" height="32" viewBox="0 0 28 32" fill="none">
                        <path d="M12.3875 1.78521C13.3867 1.21427 14.6133 1.21427 15.6125 1.78521L25.6125 7.4995C26.6251 8.07814 27.25 9.155 27.25 10.3213V21.6787C27.25 22.845 26.6251 23.9219 25.6125 24.5005L15.6125 30.2148C14.6133 30.7857 13.3867 30.7857 12.3875 30.2148L2.38755 24.5005C1.37493 23.9219 0.75 22.845 0.75 21.6787V10.3213C0.75 9.15501 1.37493 8.07814 2.38755 7.4995L12.3875 1.78521Z" stroke="var(--color-primary)" stroke-width="1.5"/>
                      </svg>
                    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">${aStep}</div>
                    </div>
                  [/#if]
                  [#if aStep != totalSteps]
                    <div class="flex items-center">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="2" viewBox="0 0 16 2" fill="none">
                        <path d="M0 1H16" stroke="#00C8A8" stroke-width="2"/>
                      </svg>
                    </div>
                  [/#if]
                [/#list]
              </div>
            [/#if]
            [#-- End Self Service Custom Registration Form Step Counter --]

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
              <fieldset class="flex flex-col gap-2 md:gap-4">
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
                <p class="text-sm text-base-content/40">Password must be more than 8 characters and include at least one symbol.</p>
                [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false" /]
                <div class="text-base-content/60">
                  <span>By registering, you agree to the <a href="${protocol}//${origin}/terms" class="text-primary underline" target="_blank">terms of service</a> and <a href="${protocol}//${origin}/privacy" class="text-primary underline" target="_blank">privacy policy</a>.</span>
                </div>
                <div class="form-row">
                  [@helpers.button color="btn btn-primary w-full" text=theme.message('register')/]
                </div>
              [#else]
                <div class="form-row">
                  [@helpers.button color="btn btn-primary" text=theme.message('next')/]
                </div>
              [/#if]
            [#-- End Custom Self Service Registration Form Steps --]
            [#else]
            [#-- Begin Basic Self Service Registration Form --]
            <fieldset class="flex flex-col gap-2 md:gap-4">
              [@helpers.hidden name="collectBirthDate"/]
              [#if !collectBirthDate && (!application.registrationConfiguration.birthDate.enabled || hideBirthDate)]
                [@helpers.hidden name="user.birthDate" dateTimeFormat="yyyy-MM-dd"/]
              [/#if]
              [#if collectBirthDate]
                [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') leftAddon="calendar" class="date-picker" required=true/]
              [/#if]
              <section class="grid grid-cols-2 gap-2 md:gap-4">
                [#if application.registrationConfiguration.firstName.enabled]
                  <div>
                    <label for="firstName">First Name</label>
                    [@helpers.input type="text" name="user.firstName" id="firstName" placeholder=theme.message('firstName') required=application.registrationConfiguration.firstName.required/]
                  </div>
                [/#if]
                [#if application.registrationConfiguration.lastName.enabled]
                  <div>
                    <label for="lastName">Last Name</label>
                    [@helpers.input type="text" name="user.lastName" id="lastName" placeholder=theme.message('lastName') required=application.registrationConfiguration.lastName.required/]
                  </div>
                [/#if]
              </section>
              <div>
                <label for="email">Email Address</label>
                [@helpers.input type="text" name="user.email" id="email" autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('email') required=true/]
              </div>
              <section class="flex gap-2 md:gap-4">
                <div class="w-full">
                  <label for="password">Password</label>
                  [@helpers.input type="password" name="user.password" id="password" autocomplete="new-password" placeholder=theme.message('password') required=true/]
                </div>
                [#if application.registrationConfiguration.confirmPassword]
                  <div class="w-full">
                    <label for="passwordConfirm">Confirm Password</label>
                    [@helpers.input type="password" name="passwordConfirm" id="passwordConfirm" autocomplete="new-password" placeholder=theme.message('passwordConfirm') required=true/]
                  </div>
                [/#if]
              </section>
              [#if application.registrationConfiguration.birthDate.enabled && !hideBirthDate]
                [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') leftAddon="calendar" class="date-picker" required=application.registrationConfiguration.birthDate.required/]
              [/#if]
              [#if application.registrationConfiguration.mobilePhone.enabled]
                [@helpers.input type="text" name="user.mobilePhone" id="mobilePhone" placeholder=theme.message('mobilePhone') leftAddon="phone" required=application.registrationConfiguration.mobilePhone.required/]
              [/#if]
              [#if application.registrationConfiguration.preferredLanguages.enabled]
                [@helpers.locale_select field="" name="user.preferredLanguages" id="preferredLanguages" label=theme.message("preferredLanguage") required=application.registrationConfiguration.preferredLanguages.required /]
              [/#if]
              [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
            </fieldset>

            <div class="w-full">
              [@helpers.button color="btn btn-primary w-full" text=theme.message('register')/]
            </div>
            [/#if]
            [#-- End Basic Self Service Registration Form --]

            [#-- Identity Provider Buttons (if you want to include these, remove the if-statement) --]
            [#if true]
              [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders![] passwordlessEnabled=false bootstrapWebauthnEnabled=false idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
            [/#if]
            [#-- End Identity Provider Buttons --]

          </form>
        </main>
      </div>
      <div class="z-10 mt-14 text-base font-medium tracking-normal text-primary-content max-md:mt-10">
        [#--  <span class="text-primary-content">${theme.message("return-to-login")} </span>  --]
        <span class="text-primary-content">
        [@helpers.link url="${request.contextPath}/oauth2/authorize"]${theme.message("return-to-login")}[/@helpers.link]
        </span>
      </div>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
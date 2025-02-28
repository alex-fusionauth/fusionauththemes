[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- Below are the main blocks for all of the themeable pages --]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="bypassTheme" type="boolean" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="consents" type="java.util.Map<java.util.UUID, java.util.List<java.lang.String>>" --]
[#-- @ftlvariable name="editPasswordOption" type="java.lang.String" --]
[#-- @ftlvariable name="locale" type="java.util.Locale" --]
[#-- @ftlvariable name="loginTheme" type="io.fusionauth.domain.Theme.Templates" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="pendingIdPLinkId" type="java.lang.String" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="response_mode" type="java.lang.String" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="theme" type="io.fusionauth.domain.Theme" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]

[#macro html]
<!DOCTYPE html>
<html lang="en" data-theme="fusionauththeme">
  [#nested/]
</html>
[/#macro]

[#macro head title="Iron Pixel" author="FusionAuth" description="User Management Redefined. A Single Sign-On solution for your entire enterprise."]
<head>
  <title>${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="application-name" content="FusionAuth">
  <meta name="author" content="FusionAuth">
  <meta name="description" content="${description}">
  <meta name="robots" content="index, follow">

  [#-- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy --]
  <meta name="referrer" content="strict-origin">

  [#--  Browser Address bar color --]
  <meta name="theme-color" content="#ffffff">

  [#-- Begin Favicon Madness
       You can check if this is working using this site https://realfavicongenerator.net/
       Questions about icon names and sizes? https://realfavicongenerator.net/faq#.XrBnPJNKg3g --]

  [#--  Standard Favicon Fare --]
  <link rel="icon" type="image/png" sizes="16x16" href="https://res.cloudinary.com/djox1exln/image/upload/w_16,h_16,c_fill/v1739291929/web-app-manifest-512x512_v756tz.png">
  <link rel="icon" type="image/png" sizes="32x32" href="https://res.cloudinary.com/djox1exln/image/upload/w_32,h_32,c_fill/v1739291929/web-app-manifest-512x512_v756tz.png">
  <link rel="icon" type="image/png" sizes="96x96" href="https://res.cloudinary.com/djox1exln/image/upload/w_96,h_96,c_fill/v1739291929/web-app-manifest-512x512_v756tz.png">
  <link rel="icon" type="image/png" sizes="128" href="https://res.cloudinary.com/djox1exln/image/upload/w_128,h_128,c_fill/v1739291929/web-app-manifest-512x512_v756tz.png">

  [#-- End Favicon Madness --]

  <link rel="stylesheet" href="/css/font-awesome-4.7.0.min.css"/>
  [#--
  <link rel="stylesheet" href="/css/fusionauth-style.css?version=${version}"/>
  --]
  [#if theme.type == "simple"]
    <link rel="stylesheet" href="/css/simple-theme.css?version=${version}"/>
  [/#if]

  [#-- Theme Stylesheet, only Authorize defines this boolean.
       Using the ?no_esc on the stylesheet to allow selectors that contain a > symbols.
       Once insde of a style tag we are safe and the stylesheet is validated not to contain an end style tag --]
  [#if !(bypassTheme!false)]
    <style>
    ${theme.stylesheet()?no_esc}
    </style>
  [/#if]

  <script src="${request.contextPath}/js/prime-min-1.7.0.js?version=${version}"></script>
  <script src="${request.contextPath}/js/Util.js?version=${version}"></script>
  <script src="${request.contextPath}/js/oauth2/LocaleSelect.js?version=${version}"></script>
  <script>
    "use strict";
    Prime.Document.onReady(function() {
      Prime.Document.query('.alert').each(function(e) {
        var dismissButton = e.queryFirst('a.dismiss-button');
        if (dismissButton !== null) {
          new Prime.Widgets.Dismissable(e, dismissButton).initialize();
        }
      });
      Prime.Document.query('[data-tooltip]').each(function(e) {
        new Prime.Widgets.Tooltip(e).withClassName('tooltip').initialize();
      });
      document.querySelectorAll('.date-picker').forEach(datePicker => {
        datePicker.onfocus = () => datePicker.type = 'date';
        datePicker.onblur = () => {
          if (datePicker.value === '') {
            datePicker.type = 'text';
          }
        };
      });
      [#-- You may optionally remove the Locale Selector, or it may not be on every page. --]
      var localeSelect = Prime.Document.queryById('locale-select');
      if (localeSelect !== null) {
        new FusionAuth.OAuth2.LocaleSelect(localeSelect);
      }
    });
    FusionAuth.Version = "${version}";
  </script>

  [#-- The nested, page-specific head HTML goes here --]
  [#nested/]

</head>
[/#macro]

[#macro body]
<body>
  <main class="">
    [#nested/]
  </main>
</body>
[/#macro]

[#macro header]
  [#if theme.type != 'simple' || request.requestURI == "/" || request.requestURI?starts_with("/account")]
    <header>
      <div class="right-menu" [#if request.requestURI == "/"]style="display: block !important;" [/#if]>
        <nav>
          <ul>
            [#if request.requestURI == "/"]
              <li><a href="${request.contextPath}/admin/" title="Administrative login"><i class="fa fa-lock" style="font-size: 18px;"></i></a></li>
            [#elseif request.requestURI?starts_with("/account")]
              <li><a href="${request.contextPath}/account/logout?client_id=${client_id!''}" title="Logout"><i class="fa fa-sign-out"></i></a></li>
            [/#if]
          </ul>
        </nav>
      </div>
    </header>
  [/#if]

  [#nested/]
[/#macro]

[#macro alternativeLoginsScript clientId identityProviders]
  [#if identityProviders["EpicGames"]?has_content || identityProviders["Facebook"]?has_content || identityProviders["Google"]?has_content ||
         identityProviders["LinkedIn"]?has_content || identityProviders["Nintendo"]?has_content || identityProviders["OpenIDConnect"]?has_content ||
         identityProviders["SAMLv2"]?has_content || identityProviders["SonyPSN"]?has_content || identityProviders["Steam"]?has_content ||
         identityProviders["Twitch"]?has_content || identityProviders["Xbox"]?has_content || identityProviders["Apple"]?has_content ||
         identityProviders["Twitter"]?has_content]
    [#-- Include Helper.js instead of loading dynamically from other IdP JS. IdP JS files will still load the script if it has not already been loaded --]
    <script id="idp_helper" src="${request.contextPath}/js/identityProvider/Helper.js?version=${version}"></script>
  [/#if]
  [#if identityProviders["Apple"]?has_content]
    <script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
    <script src="${request.contextPath}/js/identityProvider/Apple.js?version=${version}"></script>
  [/#if]
  [#if identityProviders["Facebook"]?has_content]
    <script src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script src="${request.contextPath}/js/identityProvider/Facebook.js?version=${version}" data-app-id="${identityProviders["Facebook"][0].lookupAppId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Google"]?has_content && identityProviders["Google"][0].lookupLoginMethod(clientId) != "UseRedirect"]
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script src="${request.contextPath}/js/identityProvider/Google.js?version=${version}" data-client-id="${identityProviders["Google"][0].lookupClientId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Twitter"]?has_content]
    [#-- This is the FusionAuth clientId --]
    <script src="${request.contextPath}/js/identityProvider/Twitter.js?version=${version}" data-client-id="${clientId}"></script>
  [/#if]
  [#if identityProviders["EpicGames"]?has_content || identityProviders["Facebook"]?has_content || identityProviders["Google"]?has_content ||
       identityProviders["LinkedIn"]?has_content || identityProviders["Nintendo"]?has_content || identityProviders["OpenIDConnect"]?has_content ||
       identityProviders["SAMLv2"]?has_content || identityProviders["SonyPSN"]?has_content || identityProviders["Steam"]?has_content ||
       identityProviders["Twitch"]?has_content || identityProviders["Xbox"]?has_content]
    <script src="${request.contextPath}/js/identityProvider/Redirect.js?version=${version}"></script>
  [/#if]
[/#macro]

[#macro main title="Iron Pixel" login=false]
  [#if login]
    [#assign loginUnderline = "border-b-4 border-teal-500" /]
  [#else]
    [#assign loginUnderline = "" /]
  [/#if]
  [#if !login]
    [#assign registerUnderline = "border-b-4 border-teal-500" /]
  [#else]
    [#assign registerUnderline = "" /]
  [/#if]

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
              src="https://res.cloudinary.com/djox1exln/raw/upload/v1740473944/3c4269182d3775c272e2d79990d5c1a7dfc4ba495ffbc9ea6e55e54d04364a18_prqxde"
              class="object-contain shrink-0 max-w-full aspect-[1.4] w-[175px]"
              alt="Logo"
            />
          </div>
          <div class="flex relative flex-col justify-center px-3 py-3 mt-60 bg-black bg-opacity-60 min-h-7">
            <div class="w-full max-md:max-w-full">
              <div class="flex relative flex-col items-start min-h-[5px] max-md:pr-5 max-md:max-w-full">
                <img
                  loading="lazy"
                  src="https://res.cloudinary.com/djox1exln/raw/upload/v1740474038/448e5ea2f6241981bf5c75a9c7628812968e05757b3183ac1f5b50fc28151759_xzwmog"
                  class="object-cover absolute inset-0 size-full"
                  alt="Progress bar background"
                />
                <img
                  loading="lazy"
                  src="https://res.cloudinary.com/djox1exln/raw/upload/v1740474060/d197cb55e6e5e5e43d569214b6a36438645a92c19d4ff954602f61e3e0e24af0_g4rh8p"
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
        [@printErrorAlerts rowClass="" colClass="" /]
        [@printInfoAlerts rowClass="" colClass="" /]
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
          class="object-cover absolute inset-0 size-full -z-10"
          alt="Background"
        />

      <div class="flex gap-2 items-center">
        <svg width="41" height="33" viewBox="0 0 41 33" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M4.76287 6.80489L20.0739 13.6098V32.3232L-0.000549316 22.1159L4.76287 6.80489Z" fill="url(#paint0_radial_2243_771)"/>
          <path d="M35.3849 6.80489L20.0739 13.6098V32.3232L40.1483 22.1159L35.3849 6.80489Z" fill="url(#paint1_radial_2243_771)"/>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M20.0739 2.97868L32.6629 8.57381V14.9707H7.48483V8.57381L20.0739 2.97868ZM4.76287 6.80489L20.0739 0L35.3849 6.80489V17.6927H4.76287V6.80489Z" fill="url(#paint2_radial_2243_771)"/>
          <defs>
          <radialGradient id="paint0_radial_2243_771" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(37.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
          <stop stop-color="#1AB7FF"/>
          <stop offset="0.246584" stop-color="#0DC7E3"/>
          <stop offset="0.444146" stop-color="#08C4B6"/>
          <stop offset="0.662916" stop-color="#00C288"/>
          <stop offset="1" stop-color="#00C750"/>
          </radialGradient>
          <radialGradient id="paint1_radial_2243_771" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(37.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
          <stop stop-color="#1AB7FF"/>
          <stop offset="0.246584" stop-color="#0DC7E3"/>
          <stop offset="0.444146" stop-color="#08C4B6"/>
          <stop offset="0.662916" stop-color="#00C288"/>
          <stop offset="1" stop-color="#00C750"/>
          </radialGradient>
          <radialGradient id="paint2_radial_2243_771" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(37.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
          <stop stop-color="#1AB7FF"/>
          <stop offset="0.246584" stop-color="#0DC7E3"/>
          <stop offset="0.444146" stop-color="#08C4B6"/>
          <stop offset="0.662916" stop-color="#00C288"/>
          <stop offset="1" stop-color="#00C750"/>
          </radialGradient>
          </defs>
        </svg>
        [#if title?has_content]
          <h2 class="uppercase text-6xl font-bold font-DINCondensed">${title}</h2>
        [/#if]
      </div>

      <div class="relative flex-1 mt-14 w-full max-md:mt-10 max-md:max-w-full flex flex-col gap-2 md:gap-4">
        <div class="flex items-start w-full text-xl tracking-wide leading-snug border-b border-white border-opacity-30 max-md:max-w-full">
          <div class="flex-1 shrink px-4 pb-4 font-semibold text-white min-h-11 ${loginUnderline}">
            [@helpers.link url="${request.contextPath}/oauth2/authorize"]
              Log In
            [/@helpers.link]
          </div>
          <div class="flex-1 shrink px-4 pb-4 min-h-11 text-white text-opacity-60 ${registerUnderline}">
          [@helpers.link url="${request.contextPath}/oauth2/register"]
            Sign Up
          [/@helpers.link]
          </div>
        </div>
        <div class="flex flex-col justify-center mt-6 w-full max-md:max-w-full">
          [#if login]
            <div class="text-lg leading-none text-white max-md:max-w-full">
              Log in to your Iron Pixel account.
            </div>
            <div class="mt-3 text-sm tracking-normal leading-6 text-white text-opacity-80 max-md:max-w-full">
              Your account connects you to all things Iron Pixel. Log in with
              your existing credentials to access your purchases and account
              settings.
          </div>
          [#else]
            <div class="text-lg leading-none text-white max-md:max-w-full">
              Create your Iron Pixel account.
            </div>
          [/#if]
        </div>
        <main>
          [#nested/]
          <div class="mt-2 md:mt-8"> 
            [@localSelector/]
          </div>
        </main>
      </div>
    </div>
  </section>
[/#macro]

[#macro accountMain rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4" actionURL="" actionText="Go back" actionDirection="back"]
<main class="page-body container">
  [@printErrorAlerts rowClass colClass/]
  [@printInfoAlerts rowClass colClass/]
  <div class="${rowClass}">
    <div class="${colClass}">
      [#nested/]
    </div>
  </div>
  [@accountFooter rowClass "col-xs-6 col-sm-6 col-md-5 col-lg-4" actionURL actionText actionDirection/]
</main>
[/#macro]

[#macro localSelector]
<label class="select">
  <select id="locale-select" name="locale" class="select">
    <option value="en" [#if locale == 'en']selected[/#if]>English</option>
      [#list theme.additionalLocales() as l]
        <option value="${l}" [#if locale == l]selected[/#if]>${l.getDisplayLanguage(locale)}</option>
      [/#list]
  </select>
</label>
[/#macro]

[#macro accountFooter rowClass colClass actionURL actionText actionDirection]
<div class="${rowClass}">
  <div class="${colClass}">
    [@localSelector/]
  </div>
  <div class="${colClass}" style="text-align: right;">

  [#-- actionURL and actionText may be an array. For backwards compatibility, allow a string
       or an array. If not an array yet, convert to one now. --]
  [#if !actionURL?is_sequence]
    [#local actionURLs = [actionURL]/]
  [#else]
    [#local actionURLs = actionURL/]
  [/#if]

  [#if !actionText?is_sequence]
    [#local actionTexts = [actionText]/]
  [#else]
    [#local actionTexts = actionText/]
  [/#if]

  [#list actionURLs as url]
    [#local actionURL = url/]
    [#if actionURL?has_content]
      [#if !actionURL?contains("client_id")]
        [#if actionURL?contains("?")]
         [#local actionURL = actionURL + "&client_id=${client_id}"/]
        [#else]
         [#local actionURL = actionURL + "?client_id=${client_id}"/]
        [/#if]
      [/#if]
      [#if actionDirection == "back"]
        <a href="${actionURL}"> <i class="fa fa-arrow-left"></i> ${actionTexts[url_index]}</a>
      [#else]
        <a class="d-inline-block mb-2" href="${actionURL}">${actionTexts[url_index]} <i class="fa fa-arrow-right"></i></a>
      [/#if]
      [#sep]<br>[/#sep]
    [/#if]
  [/#list]
  </div>
</div>
[/#macro]

[#macro accountPanelFull title=""]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
    [#nested/]
  </main>
</div>
[/#macro]

[#macro accountPanel title tenant user action showEdit]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
   <div class="row mb-5 user-details">
      [#-- Column 1 --]
      <div class="col-xs-12 col-md-4 col-lg-4 tight-left" style="padding-bottom: 0;">
        <div class="avatar pr-2 pb-3">
          <div>
            [#if user.imageUrl??]
              <img src="${user.imageUrl}" class="profile w-100" alt="profile image"/>
            [#elseif user.lookupEmail()??]
              <img src="${function.gravatar(user.lookupEmail(), 200)}" class="profile w-100" alt="profile image"/>
            [#else]
              <img src="${request.contextPath}/images/missing-user-image.svg" class="profile w-100" alt="profile image"/>
            [/#if]
          </div>
          <div>${display(user, "name")}</div>
       </div>
      </div>
      [#-- Column 2 --]
      <div class="col-xs-12 col-md-8 col-lg-8 tight-left">
        [#nested/]
      </div>
      [#if action == "view"]
        <div class="panel-actions">
         <div class="status">
           [#if showEdit]
            <a id="edit-profile" class="blue icon" href="${request.contextPath}/account/edit?client_id=${client_id}">
              <span style="font-size: 0.9rem;">
              <i class="fa fa-pencil blue-text" data-tooltip="${theme.message('edit-profile')}"></i>
              </span>
            </a>
           [/#if]
         </div>
       </div>
      [/#if]
  </div>
  </main>
</div>
[/#macro]

[#macro footer]
  <div class="fixed bottom-0 right-0 mb-4 mr-4 z-10">
    <a target="_blank" href="https://fusionauth.io/docs/"><i class="fa fa-question-circle-o"></i> ${theme.message("help")}</a>
  </div>
  [#nested/]
[/#macro]

[#-- Below are the social login buttons and helpers --]
[#macro appleButton identityProvider clientId]
 [#-- https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/ --]
 <button id="apple-login-button" class="apple login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-scope="${identityProvider.lookupScope(clientId)!''}" data-services-id="${identityProvider.lookupServicesId(clientId)}">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg version="1.1" viewBox="4 6 30 30" xmlns="http://www.w3.org/2000/svg">
        <g id="Left-Black-Logo-Large" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
          <path class="cls-1" d="M19.8196726,13.1384615 C20.902953,13.1384615 22.2608678,12.406103 23.0695137,11.4296249 C23.8018722,10.5446917 24.3358837,9.30883662 24.3358837,8.07298156 C24.3358837,7.9051494 24.3206262,7.73731723 24.2901113,7.6 C23.0847711,7.64577241 21.6353115,8.4086459 20.7656357,9.43089638 C20.0790496,10.2090273 19.4534933,11.4296249 19.4534933,12.6807374 C19.4534933,12.8638271 19.4840083,13.0469167 19.4992657,13.1079466 C19.5755531,13.1232041 19.6976128,13.1384615 19.8196726,13.1384615 Z M16.0053051,31.6 C17.4852797,31.6 18.1413509,30.6082645 19.9875048,30.6082645 C21.8641736,30.6082645 22.2761252,31.5694851 23.923932,31.5694851 C25.5412238,31.5694851 26.6245041,30.074253 27.6467546,28.6095359 C28.7910648,26.9312142 29.2640464,25.2834075 29.2945613,25.2071202 C29.1877591,25.1766052 26.0904927,23.9102352 26.0904927,20.3552448 C26.0904927,17.2732359 28.5316879,15.8848061 28.6690051,15.7780038 C27.0517133,13.4588684 24.5952606,13.3978385 23.923932,13.3978385 C22.1082931,13.3978385 20.6283185,14.4963764 19.6976128,14.4963764 C18.6906198,14.4963764 17.36322,13.4588684 15.7917006,13.4588684 C12.8012365,13.4588684 9.765,15.9305785 9.765,20.5993643 C9.765,23.4982835 10.8940528,26.565035 12.2824825,28.548506 C13.4725652,30.2268277 14.5100731,31.6 16.0053051,31.6 Z" id=""  fill-rule="nonzero"></path>
        </g>
      </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro epicButton identityProvider clientId]
<button id="epicgames-login-button" class="epicgames login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
        <rect width="32" height="32" rx="2" fill="#242423"/>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M9.45348 7.11255H22.5465C23.608 7.11255 24 7.50451 24 8.5666V21.3845C24.0004 21.4965 23.9952 21.6084 23.9843 21.7199C23.9823 21.739 23.9805 21.7581 23.9786 21.7772C23.958 21.9881 23.9375 22.1975 23.7399 22.4321C23.7194 22.4574 23.499 22.6212 23.499 22.6212C23.4787 22.6312 23.4596 22.6407 23.4411 22.6499C23.3513 22.6945 23.2769 22.7315 23.1661 22.7759L16.7177 25.4787C16.3829 25.6322 16.2408 25.6918 16 25.687C15.7574 25.6918 15.6171 25.6322 15.2823 25.4787L8.83393 22.7759C8.70878 22.7252 8.63166 22.6866 8.52351 22.6325C8.51615 22.6288 8.50864 22.625 8.50097 22.6212C8.50097 22.6212 8.28121 22.4574 8.26013 22.4321C8.06227 22.1972 8.04198 21.9887 8.02135 21.7768C8.01951 21.7578 8.01766 21.7389 8.01568 21.7199C8.00478 21.6084 7.99955 21.4965 8.00003 21.3845V8.5666C8.00003 7.50451 8.39199 7.11255 9.45348 7.11255ZM20.5779 15.3903V13.7827H21.64V15.4432C21.64 16.3307 21.2053 16.7678 20.3244 16.7678H19.788C18.9077 16.7678 18.4724 16.3283 18.4724 15.4432V10.8445C18.4724 9.9576 18.9077 9.51988 19.788 9.51988H20.3142C21.1944 9.51988 21.6195 9.94736 21.6195 10.8324V12.2877H20.5568V10.8932C20.5568 10.6085 20.425 10.476 20.1516 10.476H19.971C19.688 10.476 19.5562 10.6085 19.5562 10.8932V15.3903C19.5562 15.675 19.6874 15.8075 19.971 15.8075H20.1733C20.446 15.8075 20.5779 15.675 20.5779 15.3903ZM11.4436 13.569H12.7188V12.5822H11.4436V10.5682H12.7694V9.5814H10.3604V16.7029H12.7898V15.7161H11.4436V13.569ZM12.3885 20.3136L12.365 20.331L12.3445 20.3461L12.3211 20.3635L12.2976 20.3786L12.2741 20.3961L12.2506 20.4111L12.2271 20.4262L12.2006 20.4406L12.1742 20.4557L12.1477 20.4707L12.1212 20.4822L12.0947 20.4972L12.0652 20.5092L12.0387 20.5213L12.0092 20.5333L11.9827 20.5454L11.9562 20.5544L11.9297 20.5634L11.9032 20.5725L11.8737 20.5815L11.8472 20.5905L11.8177 20.5965L11.7912 20.6026L11.7617 20.6086L11.7322 20.6146H11.7027H11.6702H11.6407H11.6082H11.5787H11.5462H11.4197H11.3902H11.3577H11.3282H11.2987H11.2692L11.2397 20.6086L11.2102 20.6026L11.1837 20.5965L11.1542 20.5905L11.1277 20.5815L11.0982 20.5755L11.0717 20.5664L11.0452 20.5544L11.0187 20.5454L10.9892 20.5333L10.9627 20.5213L10.9363 20.5092L10.9098 20.4972L10.8833 20.4822L10.8598 20.4677L10.8333 20.4527L10.8098 20.4376L10.7863 20.4231L10.7629 20.4051L10.7394 20.3876L10.7159 20.3702L10.6954 20.3527L10.6749 20.3352L10.6545 20.3148L10.634 20.2973L10.6135 20.2768L10.5931 20.2564L10.5756 20.2359L10.5581 20.2124L10.5407 20.1919L10.5256 20.1685L10.5082 20.145L10.4937 20.1215L10.4793 20.098L10.4642 20.0715L10.4492 20.048L10.4377 20.0216L10.4257 19.9951L10.4136 19.9686L10.4022 19.9421L10.3932 19.9186L10.3811 19.8921L10.3751 19.8656L10.3667 19.8391L10.3607 19.8096L10.3516 19.7831L10.3456 19.7536V19.7271L10.3396 19.6976V19.6711V19.6416V19.6121V19.5826V19.4851V19.4526V19.4231V19.3936V19.3611L10.3456 19.3316V19.3021L10.3516 19.2756L10.3607 19.2461L10.3667 19.2166L10.3751 19.1901L10.3841 19.1606L10.3932 19.1341L10.4052 19.1046L10.4166 19.0781L10.4287 19.0516L10.4407 19.0251L10.4522 18.9986L10.4672 18.9721L10.4823 18.9486L10.4967 18.9251L10.5112 18.9017L10.5262 18.8782L10.5437 18.8547L10.5612 18.8312L10.5786 18.8077L10.5961 18.7873L10.6165 18.7668L10.634 18.7463L10.6545 18.7259L10.6749 18.7054L10.6954 18.6879L10.7189 18.6675L10.7394 18.65L10.7629 18.6277L10.7863 18.6127L10.8098 18.5952L10.8333 18.5802L10.8568 18.5651L10.8833 18.55L10.9098 18.535L10.9363 18.5199L10.9627 18.5079L10.9892 18.4959L11.0187 18.4808L11.0422 18.4718L11.0717 18.4627L11.0982 18.4507L11.1247 18.4447L11.1512 18.4356L11.1807 18.4296L11.2072 18.4206L11.2367 18.4146H11.2662L11.2957 18.4086H11.3252H11.3547H11.3842H11.4137H11.5402H11.5727H11.6052H11.6347H11.6642L11.6967 18.4146H11.7232L11.7527 18.4206L11.7822 18.4266L11.8087 18.4326L11.8352 18.4387L11.8617 18.4447L11.8882 18.4537L11.9147 18.4597L11.9381 18.4688L11.9646 18.4778L11.9911 18.4898L12.0176 18.5019L12.0441 18.5139L12.0706 18.529L12.0971 18.541L12.1206 18.5561L12.1471 18.5711L12.1705 18.5862L12.197 18.6012L12.2205 18.6187L12.244 18.6337L12.2675 18.6512L12.291 18.6687L12.3144 18.6891L12.3379 18.7066L12.3205 18.7301L12.3 18.7505L12.2825 18.774L12.2621 18.7975L12.2446 18.821L12.2271 18.8415L12.2067 18.8649L12.1892 18.8884L12.1717 18.9089L12.1513 18.9324L12.1338 18.9559L12.1133 18.9793L12.0959 18.9998L12.0784 19.0233L12.0579 19.0468L12.0405 19.0702L12.02 19.0907L12.0026 19.1142L11.9791 19.0967L11.9556 19.0763L11.9321 19.0612L11.9086 19.0438L11.8851 19.0287L11.8617 19.0137L11.8382 18.9992L11.8117 18.9842L11.7882 18.9721L11.7647 18.9601L11.7412 18.951L11.7148 18.942L11.6883 18.933L11.6618 18.927L11.6323 18.9209L11.6028 18.9149H11.5733H11.5408H11.5082H11.448H11.4185H11.392L11.3625 18.9209L11.336 18.927L11.3095 18.936L11.2831 18.945L11.2566 18.9571L11.2301 18.9691L11.2066 18.9842L11.1831 18.9992L11.1596 19.0143L11.1392 19.0317L11.1187 19.0492L11.0982 19.0666L11.0808 19.0871L11.0603 19.1076L11.0428 19.1311L11.0284 19.1515L11.0133 19.175L10.9989 19.2015L10.9838 19.225L10.9718 19.2515L10.9627 19.278L10.9513 19.3045L10.9423 19.334L10.9363 19.3635L10.9302 19.39L10.9242 19.4225V19.452V19.4815V19.5495V19.579V19.6055V19.635L10.9302 19.6615L10.9363 19.688L10.9423 19.7145L10.9513 19.741L10.9597 19.7645L10.9718 19.794L10.9838 19.8205L10.9983 19.8469L11.0133 19.8704L11.0284 19.8939L11.0458 19.9174L11.0633 19.9379L11.0838 19.9583L11.1018 19.9788L11.1223 19.9963L11.1458 20.0137L11.1693 20.0312L11.1927 20.0462L11.2162 20.0613L11.2427 20.0733L11.2692 20.0854L11.2957 20.0974L11.3252 20.1064L11.3547 20.1155L11.3842 20.1215L11.4137 20.1275H11.4432H11.4757H11.5432H11.5757H11.6082H11.6377L11.6672 20.1215L11.6967 20.1155L11.7262 20.1064L11.7527 20.1004L11.7792 20.0884L11.8027 20.0763L11.8292 20.0643L11.8496 20.0523L11.8731 20.0372V19.7717H11.4432V19.34H12.4144V20.3033L12.3885 20.3136ZM14.9666 20.5881H14.3898L14.3784 20.5616L14.3694 20.5351L14.3573 20.5086L14.3453 20.4791L14.3369 20.4527L14.3248 20.4262L14.3128 20.3997L14.3043 20.3732L14.2923 20.3467L14.2803 20.3202L14.2712 20.2937L14.2598 20.2642L14.2477 20.2377L14.2387 20.2112L14.2267 20.1847H13.3837L13.3723 20.2112L13.3633 20.2377L13.3512 20.2642L13.3392 20.2937L13.3308 20.3202L13.3187 20.3467L13.3067 20.3732L13.2977 20.3997L13.2862 20.4262L13.2742 20.4527L13.2651 20.4791L13.2537 20.5086L13.2417 20.5351L13.2326 20.5616L13.2206 20.5881H12.6293L12.6408 20.5616L12.6528 20.5351L12.6649 20.5086L12.6763 20.4791L12.6853 20.4527L12.6974 20.4262L12.7094 20.3997L12.7208 20.3732L12.7329 20.3467L12.7449 20.3172L12.7564 20.2907L12.7684 20.2642L12.7774 20.2377L12.7895 20.2112L12.8009 20.1847L12.813 20.1552L12.825 20.1287L12.8365 20.1022L12.8485 20.0757L12.8605 20.0492L12.8696 20.0228L12.881 19.9933L12.893 19.9668L12.9051 19.9403L12.9165 19.9138L12.9286 19.8873L12.9406 19.8608L12.9521 19.8313L12.9611 19.8048L12.9731 19.7783L12.9852 19.7518L12.9966 19.7253L13.0086 19.6988L13.0207 19.6693L13.0321 19.6428L13.0442 19.6163L13.0508 19.5911L13.0628 19.5646L13.0743 19.5381L13.0863 19.5086L13.0984 19.4821L13.1098 19.4556L13.1218 19.4291L13.1339 19.4026L13.1429 19.3761L13.1544 19.3496L13.1664 19.3201L13.1784 19.2936L13.1899 19.2671L13.2019 19.2406L13.214 19.2141L13.2254 19.1877L13.2344 19.1582L13.2465 19.1317L13.2585 19.1052L13.27 19.0787L13.282 19.0522L13.294 19.0257L13.3055 18.9962L13.3175 18.9697L13.3266 18.9432L13.3386 18.9167L13.35 18.8902L13.3621 18.8637L13.3741 18.8342L13.3856 18.8077L13.3976 18.7812L13.4096 18.7548L13.4181 18.7283L13.4301 18.7018L13.4422 18.6723L13.4542 18.6458L13.4656 18.6193L13.4777 18.5928L13.4897 18.5663L13.5012 18.5398L13.5102 18.5103L13.5222 18.4838L13.5343 18.4573L13.5457 18.4308H14.0876L14.0996 18.4573L14.1117 18.4838L14.1231 18.5103L14.1352 18.5398L14.1442 18.5663L14.1556 18.5928L14.1677 18.6193L14.1797 18.6458L14.1918 18.6723L14.2032 18.7018L14.2152 18.7283L14.2273 18.7548L14.2357 18.7812L14.2477 18.8077L14.2598 18.8342L14.2718 18.8637L14.2833 18.8902L14.2953 18.9167L14.3074 18.9432L14.3188 18.9697L14.3278 18.9962L14.3399 19.0257L14.3513 19.0522L14.3633 19.0787L14.3754 19.1052L14.3874 19.1317L14.3989 19.1582L14.4109 19.1877L14.4199 19.2141L14.4314 19.2406L14.4434 19.2671L14.4555 19.2936L14.4675 19.3201L14.479 19.3496L14.491 19.3761L14.503 19.4026L14.5115 19.4291L14.5235 19.4556L14.5355 19.4821L14.547 19.5086L14.559 19.5381L14.5711 19.5646L14.5831 19.5911L14.5946 19.6176L14.6036 19.644L14.6156 19.6705L14.6271 19.7L14.6391 19.7265L14.6511 19.753L14.6632 19.7795L14.6746 19.806L14.6867 19.8325L14.6957 19.862L14.7071 19.8885L14.7192 19.915L14.7312 19.9415L14.7427 19.968L14.7547 19.9945L14.7668 20.024L14.7788 20.0505L14.7872 20.0769L14.7993 20.1034L14.8113 20.1299L14.8227 20.1564L14.8348 20.1859L14.8468 20.2124L14.8589 20.2389L14.8703 20.2654L14.8793 20.2919L14.8914 20.3184L14.9028 20.3479L14.9149 20.3744L14.9269 20.4009L14.9383 20.4274L14.9504 20.4539L14.9624 20.4803L14.9715 20.5098L14.9829 20.5363L14.9949 20.5628L15.007 20.5893L14.9666 20.5881ZM14.0424 19.7012L14.0334 19.6747L14.022 19.6452L14.0099 19.6188L14.0009 19.5923L13.9895 19.5658L13.9774 19.5363L13.9684 19.5098L13.9563 19.4833L13.9449 19.4568L13.9359 19.4303L13.9238 19.4008L13.9154 19.3743L13.9034 19.3478L13.8913 19.3213L13.8823 19.2948L13.8708 19.2653L13.8588 19.2388L13.8498 19.2123L13.8377 19.1859L13.8263 19.1564L13.8173 19.1299L13.8052 19.1034L13.7938 19.1299L13.7847 19.1564L13.7727 19.1859L13.7607 19.2123L13.7522 19.2388L13.7402 19.2653L13.7281 19.2948L13.7167 19.3213L13.7131 19.3502L13.7011 19.3767L13.689 19.4032L13.6806 19.4327L13.6685 19.4592L13.6565 19.4857L13.6475 19.5122L13.636 19.5387L13.624 19.5682L13.6119 19.5947L13.6035 19.6212L13.5915 19.6477L13.5794 19.6772L13.5704 19.7036L13.559 19.7301H14.0563L14.0424 19.7012ZM17.4581 20.5905H16.9198V19.3177L16.9054 19.3412L16.8879 19.3683L16.8729 19.3918L16.8554 19.4152L16.8403 19.4417L16.8223 19.4652L16.8078 19.4887L16.7928 19.5152L16.7753 19.5387L16.7603 19.5622L16.7428 19.5856L16.7284 19.6121L16.7109 19.6356L16.6964 19.6591L16.6814 19.6856L16.6639 19.7097L16.6495 19.7332L16.632 19.7596L16.6176 19.7831L16.6001 19.8066L16.5857 19.8331L16.5706 19.8566L16.5532 19.8801L16.5387 19.9066L16.5212 19.9306L16.5068 19.9541L16.4893 19.9776L16.4743 20.0041L16.4598 20.0282L16.4424 20.0517L16.4279 20.0782L16.4105 20.1016L16.3954 20.1251L16.3779 20.1522L16.3629 20.1757H16.3515L16.334 20.1492L16.3189 20.1251L16.3015 20.0986L16.2864 20.0751L16.269 20.0486L16.2539 20.0246L16.2365 19.9981L16.2214 19.9746L16.2039 19.9481L16.1895 19.9246L16.172 19.8975L16.1576 19.874L16.1401 19.8475L16.1251 19.8241L16.1076 19.7976L16.0926 19.7741L16.0751 19.7476L16.0576 19.7241L16.0426 19.6976L16.0251 19.6741L16.0101 19.6477L15.9926 19.6242L15.9776 19.5971L15.9601 19.5736L15.945 19.5471L15.9276 19.5236L15.9131 19.4971L15.8957 19.473L15.8812 19.4466L15.8638 19.4231L15.8487 19.3966L15.8312 19.3731L15.8162 19.346L15.7987 19.3225V20.5869H15.2364V18.4387H15.8385L15.8529 18.4621L15.868 18.4886L15.8854 18.5121L15.9005 18.5386L15.9155 18.5621L15.93 18.5886L15.945 18.6121L15.9625 18.6386L15.977 18.662L15.992 18.6855L16.0065 18.712L16.0215 18.7355L16.039 18.762L16.054 18.7855L16.0691 18.812L16.0835 18.8354L16.101 18.8589L16.116 18.8854L16.1305 18.9089L16.1455 18.9354L16.16 18.9589L16.1774 18.9854L16.1925 19.0088L16.2069 19.0353L16.222 19.0588L16.2365 19.0823L16.2539 19.1088L16.269 19.1323L16.2834 19.1588L16.2985 19.1822L16.3129 19.2087L16.331 19.2322L16.346 19.2587L16.3605 19.2822L16.3755 19.2587L16.3906 19.2322L16.408 19.2087L16.4225 19.1822L16.4369 19.1588L16.452 19.1323L16.4695 19.1088L16.4845 19.0823L16.4996 19.0588L16.514 19.0353L16.5315 19.0088L16.5429 18.989L16.558 18.9625L16.5724 18.939L16.5899 18.9125L16.6049 18.889L16.62 18.8625L16.6344 18.839L16.6495 18.8156L16.6669 18.7891L16.682 18.7656L16.6971 18.7391L16.7115 18.7156L16.729 18.6891L16.7434 18.6656L16.7579 18.6422L16.7729 18.6157L16.7904 18.5922L16.8054 18.5657L16.8199 18.5422L16.8349 18.5157L16.8524 18.4922L16.8668 18.4658L16.8819 18.4423H17.484V20.5905H17.4581ZM19.6082 20.5905H17.9223V18.4387H19.6232V18.9288H18.4841V19.2804H19.5076V19.7386H18.4841V20.1052H19.6377V20.5929L19.6082 20.5905ZM21.6715 19.9993V20.0288V20.0613L21.6655 20.0908L21.6565 20.1203L21.6504 20.1468L21.6414 20.1763L21.6294 20.2028L21.6173 20.2263L21.6005 20.2534L21.5854 20.2768L21.5704 20.3003L21.5529 20.3238L21.5379 20.3473L21.5204 20.3678L21.4999 20.3882L21.4825 20.4057L21.459 20.4262L21.4385 20.4436L21.415 20.4611L21.3915 20.4755L21.3681 20.493L21.3416 20.508L21.3151 20.5201L21.2886 20.5351L21.2591 20.5472L21.2296 20.5592L21.2001 20.5682L21.1706 20.5773L21.1441 20.5863L21.1146 20.5923L21.0881 20.5984L21.0616 20.6044L21.0321 20.6104H21.0026H20.9761H20.9466H20.9141H20.8846H20.7612H20.7317H20.6991H20.6696H20.6401H20.6076L20.5781 20.6044H20.5486L20.5191 20.5984L20.4896 20.5923L20.4601 20.5863L20.4306 20.5803L20.4011 20.5713L20.3746 20.5652L20.3451 20.5562L20.3156 20.5472L20.2891 20.5351L20.2596 20.5261L20.2331 20.5171L20.2036 20.505L20.1771 20.493L20.1506 20.4809L20.1241 20.4665L20.0977 20.4545L20.0712 20.4394L20.0477 20.425L20.0212 20.4099L19.9977 20.3948L19.9742 20.3798L19.9507 20.3623L19.9273 20.3449L19.9038 20.3274L19.8803 20.31L19.8598 20.2925L19.8363 20.272L19.8544 20.2534L19.8749 20.2329L19.8923 20.2094L19.9128 20.1859L19.9303 20.1655L19.9477 20.142L19.9682 20.1185L19.9857 20.098L20.0061 20.0745L20.0236 20.0541L20.0441 20.0306L20.0615 20.0071L20.079 19.9866L20.0995 19.9632L20.1169 19.9397L20.1374 19.9192L20.1549 19.8957L20.1783 19.9132L20.2048 19.9306L20.2283 19.9481L20.2548 19.9656L20.2783 19.9806L20.3048 19.9981L20.3283 20.0131L20.3547 20.0252L20.3782 20.0402L20.4047 20.0523L20.4312 20.0643L20.4577 20.0763L20.4842 20.0854L20.5107 20.0974L20.5402 20.1064L20.5697 20.1155L20.5962 20.1245L20.6257 20.1305L20.6552 20.1366L20.6847 20.1426H20.7172L20.7467 20.1486H20.7762H20.8087H20.878H20.9105L20.94 20.1426L20.9665 20.1366L20.993 20.1305L21.0164 20.1215L21.0369 20.1095L21.0604 20.092L21.0779 20.0715L21.0899 20.048L21.0989 20.0216V19.992V19.986V19.9505L21.0869 19.921L21.0718 19.9005L21.0514 19.8831L21.0279 19.8656L21.0044 19.8536L20.9779 19.8415L20.9484 19.8295L20.9129 19.815L20.8924 19.809L20.8689 19.803L20.8424 19.794L20.8159 19.7879L20.7864 19.7789L20.7575 19.7717L20.725 19.7627L20.6955 19.7566L20.663 19.7476L20.6335 19.7416L20.604 19.7325L20.5745 19.7265L20.545 19.7175L20.5185 19.7085L20.489 19.7024L20.4625 19.6934L20.436 19.6844L20.4095 19.6754L20.377 19.6633L20.3475 19.6513L20.318 19.6392L20.2885 19.6272L20.262 19.6121L20.2325 19.5971L20.209 19.582L20.1826 19.567L20.1591 19.5495L20.1356 19.5345L20.1151 19.5164L20.0946 19.4959L20.0742 19.4755L20.0567 19.455L20.0393 19.4345L20.0242 19.414L20.0098 19.3906L19.9947 19.3641L19.9827 19.3436L19.9736 19.3201L19.9652 19.2936L19.9562 19.2701L19.9501 19.2406L19.9441 19.2141V19.1846V19.1551V19.1226V19.0546V19.0251V18.9986V18.9691L19.9501 18.9426L19.9562 18.9161L19.9652 18.8896L19.9712 18.8631L19.9827 18.8366L19.9947 18.8102L20.0067 18.7837L20.0212 18.7572L20.0356 18.7307L20.0531 18.7072L20.0712 18.6837L20.0916 18.6602L20.1121 18.6398L20.1326 18.6163L20.1561 18.5958L20.1765 18.5807L20.2 18.5633L20.2235 18.5458L20.247 18.5308L20.2735 18.5157L20.3 18.5037L20.3265 18.4886L20.3529 18.4766L20.3824 18.4676L20.4119 18.4555L20.4384 18.4465L20.4619 18.4405L20.4884 18.4344L20.5149 18.4284L20.5444 18.4224L20.5709 18.4164H20.6004H20.6299H20.6594H20.6889H20.8178H20.8503H20.8828H20.9123H20.9448L20.9743 18.4224H21.0068L21.0363 18.4284L21.0628 18.4344L21.0923 18.4405L21.1218 18.4465L21.1483 18.4525L21.1778 18.4615L21.2043 18.4706L21.2308 18.4766L21.2603 18.4886L21.2868 18.4977L21.3133 18.5097L21.3398 18.5217L21.3693 18.5338L21.3958 18.5488L21.4192 18.5609L21.4457 18.5759L21.4722 18.591L21.4957 18.606L21.5222 18.6235L21.5457 18.6379L21.5692 18.656L21.5926 18.6735L21.6161 18.6909L21.5987 18.7144L21.5836 18.7379L21.5662 18.7614L21.5487 18.7849L21.5312 18.8114L21.5162 18.8348L21.4987 18.8583L21.4813 18.8818L21.4668 18.9053L21.4493 18.9288L21.4319 18.9522L21.4168 18.9757L21.3994 19.0022L21.3813 19.0257L21.3596 19.0492L21.3446 19.0727L21.3271 19.0961L21.3036 19.0787L21.2772 19.0636L21.2537 19.0486L21.2302 19.0311L21.2037 19.0191L21.1802 19.004L21.1537 18.992L21.1302 18.9799L21.1037 18.9679L21.0803 18.9559L21.0538 18.9468L21.0303 18.9348L20.9984 18.9288L20.9689 18.9197L20.9394 18.9107L20.9099 18.9047L20.8804 18.8987L20.8509 18.8926H20.8214H20.7919H20.7654H20.7009L20.6684 18.8987L20.6389 18.9047L20.6124 18.9107L20.589 18.9227L20.5685 18.9348L20.542 18.9583L20.5245 18.9848L20.5131 19.0112V19.0407V19.0468V19.0853L20.5275 19.1178L20.5396 19.1353L20.5601 19.1557L20.5866 19.1708L20.61 19.1859L20.6395 19.1979L20.6721 19.2099L20.7076 19.222L20.7311 19.228L20.7545 19.237L20.781 19.243L20.8075 19.2521L20.837 19.2581L20.8695 19.2671L20.902 19.2762L20.9346 19.2852L20.9671 19.2912L20.9966 19.3002L21.0291 19.3093L21.0586 19.3153L21.0881 19.3243L21.1176 19.3334L21.1441 19.3424L21.1736 19.3514L21.2001 19.3605L21.2266 19.3695L21.2591 19.3809L21.2886 19.396L21.3181 19.408L21.3476 19.4231L21.3741 19.4381L21.4006 19.4532L21.4241 19.4682L21.4475 19.4857L21.471 19.5007L21.4945 19.5212L21.518 19.5417L21.5385 19.5652L21.5589 19.5856L21.5764 19.6091L21.5939 19.6356L21.6083 19.6591L21.6234 19.6856L21.6354 19.7091L21.6444 19.7356L21.6529 19.7621L21.6589 19.7885L21.6649 19.818L21.6709 19.8475V19.8771V19.9096V19.9806L21.6715 19.9993ZM17.8993 9.5814H16.8161V16.7029H17.8993V9.5814ZM13.3135 9.58121H15.0138L15.0144 9.5788C15.8947 9.5788 16.33 10.0183 16.33 10.9034V12.794C16.33 13.6814 15.8953 14.1186 15.0144 14.1186H14.3973V16.7009H13.3135V9.58121ZM14.8428 13.16C15.1162 13.16 15.2475 13.0276 15.2475 12.7428V10.9522C15.2475 10.6674 15.1162 10.5349 14.8428 10.5349H14.3973V13.16H14.8428ZM12.9151 23.1423H19.1154L15.9508 24.1863L12.9151 23.1423Z" fill="white"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
</button>
[/#macro]

[#macro facebookButton identityProvider clientId]
 <button id="facebook-login-button" class="facebook login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="${identityProvider.lookupLoginMethod(clientId)!''}" data-permissions="${identityProvider.lookupPermissions(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
       <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 216 216">
         <path class="cls-1" d="M204.1 0H11.9C5.3 0 0 5.3 0 11.9v192.2c0 6.6 5.3 11.9 11.9 11.9h103.5v-83.6H87.2V99.8h28.1v-24c0-27.9 17-43.1 41.9-43.1 11.9 0 22.2.9 25.2 1.3v29.2h-17.3c-13.5 0-16.2 6.4-16.2 15.9v20.8h32.3l-4.2 32.6h-28V216h55c6.6 0 11.9-5.3 11.9-11.9V11.9C216 5.3 210.7 0 204.1 0z"></path>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro googleButton identityProvider clientId idpRedirectState=""]
  [#-- When using this loginMethod - the Google JavaScript API is not used at all. --]
  [#if identityProvider.lookupLoginMethod(clientId) == "UseRedirect"]
    <button id="google-login-button" class="google login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
      <div>
       <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
         <svg version="1.1" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
           <g>
             <path class="cls-1" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
             <path class="cls-2" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
             <path class="cls-3" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
             <path class="cls-4" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
             <path class="cls-5" d="M0 0h48v48H0z"></path>
           </g>
         </svg>
       </div>
       <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
      </div>
    </button>
  [#else] [#-- UsePopup or UseVendorJavaScript --]
    [#--
     Use the Google Identity Service (GIS) API.
     https://developers.google.com/identity/gsi/web/reference/html-reference
    --]
    <div id="g_id_onload" [#list identityProvider.lookupAPIProperties(clientId)!{} as attribute, value] data-${attribute}="${value}" [/#list]
         data-client_id="${identityProvider.lookupClientId(clientId)}"
         data-callback="googleLoginCallback" >
    </div>
    [#-- This the Google Signin button. If only using One tap, you can delete or commment out this element --]
    <div class="g_id_signin" [#list identityProvider.lookupButtonProperties(clientId)!{} as attribute, value] data-${attribute}="${value}" [/#list]
         [#-- Optional click handler, when using ux_mode=popup. --]
         data-click_listener="googleButtonClickHandler" >
    </div>
  [/#if]
[/#macro]

[#macro linkedInBottom identityProvider clientId]
 <button id="linkedin-login-button" class="linkedin login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
       <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
            viewBox="0 0 382 382" style="enable-background:new 0 0 382 382;" xml:space="preserve">
       <path style="fill:#0077B7;" d="M347.445,0H34.555C15.471,0,0,15.471,0,34.555v312.889C0,366.529,15.471,382,34.555,382h312.889
        C366.529,382,382,366.529,382,347.444V34.555C382,15.471,366.529,0,347.445,0z M118.207,329.844c0,5.554-4.502,10.056-10.056,10.056
        H65.345c-5.554,0-10.056-4.502-10.056-10.056V150.403c0-5.554,4.502-10.056,10.056-10.056h42.806
        c5.554,0,10.056,4.502,10.056,10.056V329.844z M86.748,123.432c-22.459,0-40.666-18.207-40.666-40.666S64.289,42.1,86.748,42.1
        s40.666,18.207,40.666,40.666S109.208,123.432,86.748,123.432z M341.91,330.654c0,5.106-4.14,9.246-9.246,9.246H286.73
        c-5.106,0-9.246-4.14-9.246-9.246v-84.168c0-12.556,3.683-55.021-32.813-55.021c-28.309,0-34.051,29.066-35.204,42.11v97.079
        c0,5.106-4.139,9.246-9.246,9.246h-44.426c-5.106,0-9.246-4.14-9.246-9.246V149.593c0-5.106,4.14-9.246,9.246-9.246h44.426
        c5.106,0,9.246,4.14,9.246,9.246v15.655c10.497-15.753,26.097-27.912,59.312-27.912c73.552,0,73.131,68.716,73.131,106.472
        L341.91,330.654L341.91,330.654z"/>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro nintendoButton identityProvider clientId]
<button id="nintendo-login-button" class="nintendo login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.756 192.756">
        <g>
          <path fill="#cc2131" d="M27.305 119.422c-14.669-.004-24.47-10.398-24.47-23.002 0-12.605 9.826-23.119 24.449-23.086h138.189c14.623-.033 24.449 10.481 24.449 23.086 0 12.604-9.803 22.998-24.473 23.002H27.305z"/>
          <path fill="#fff" d="M27.351 79.005c-11.613.02-18.743 7.783-18.743 17.384 0 9.6 7.084 17.424 18.743 17.381h138.052c11.658.043 18.746-7.781 18.746-17.381 0-9.601-7.131-17.363-18.746-17.384H27.351z"/>
          <path fill="#cc2131" d="M21.396 85.491h6.756l9.355 15.128-.005-15.128h6.705v21.698h-6.696L28.109 92.06v15.129h-6.716l.003-21.698zM80.674 87.725h6.53v2.919h3.533v2.143h-3.533l.004 14.402h-6.534l.003-14.402h-3.546v-2.141h3.548l-.005-2.921zM47.943 92.761h6.525v14.428h-6.525V92.761zM47.929 85.487h6.539v4.436h-6.539v-4.436zM164.898 99.859s-.004 2.178-.004 3.055c0 2.299-1.357 3.25-2.668 3.25-1.305 0-2.672-.951-2.672-3.25 0-.877.004-3.109.004-3.109s.006-2.133.006-3.01c0-2.29 1.361-3.232 2.662-3.232s2.668.942 2.668 3.232c0 .877 0 2.492.004 3.074v-.01zm-2.621-8.084c-5.264 0-9.531 3.628-9.531 8.104 0 4.473 4.268 8.1 9.531 8.1 5.27 0 9.537-3.627 9.537-8.1 0-4.476-4.267-8.104-9.537-8.104zM144.18 85.491h6.439v21.694h-6.449l-.004-.83c-2.494 1.566-5.316 1.562-7.512.541-.588-.275-4.463-2.135-4.463-7.152 0-3.812 3.596-7.969 8.295-7.557 1.549.138 2.648.702 3.693 1.287l.001-7.983zm.047 14.411v-2.578c0-2.232-1.539-2.8-2.555-2.8-1.041 0-2.561.568-2.561 2.8 0 .736.004 2.572.004 2.572s-.004 1.795-.004 2.564c0 2.23 1.52 2.812 2.561 2.812 1.016 0 2.555-.582 2.555-2.812v-2.558zM69.741 92.094c2.438-.067 7.39 1.53 7.354 7.244-.007 1.012-.002 7.848-.002 7.848h-6.482v-9.475c0-1.259-1.203-2.658-2.979-2.658-1.779 0-3.099 1.399-3.099 2.658l.007 9.475h-6.479l-.005-14.427 6.483-.005s-.007 1.162 0 1.516a7.872 7.872 0 0 1 5.202-2.176zM122.768 92.094c2.434-.067 7.385 1.53 7.354 7.244-.01 1.012-.006 7.848-.006 7.848h-6.482v-9.475c0-1.259-1.201-2.658-2.979-2.658s-3.102 1.399-3.102 2.658l.01 9.475h-6.477l.004-14.427 6.473-.005s-.01 1.162 0 1.516a7.869 7.869 0 0 1 5.205-2.176zM96.816 97.789c-.012-1.262.014-2.106.428-2.832.514-.888 1.451-1.311 2.299-1.315h-.004c.854.004 1.785.427 2.295 1.315.414.725.438 1.57.428 2.832h-5.446zm5.418 4.352s.006.064.006.877c0 2.639-1.736 3.227-2.697 3.227-.965 0-2.732-.588-2.732-3.227 0-.793.01-2.98.01-2.98s12.287.004 12.287 0c0-4.476-4.318-8.183-9.625-8.183-5.304 0-9.607 3.628-9.607 8.099 0 4.477 4.303 8.105 9.607 8.105 4.402 0 8.119-2.514 9.258-5.924l-6.507.006zM172.268 90.654h-.752v-4.941h1.885c1.164 0 1.744.431 1.744 1.404 0 .883-.555 1.268-1.283 1.361l1.404 2.176h-.836l-1.305-2.143h-.857v2.143zm.894-2.778c.635 0 1.197-.044 1.197-.804 0-.611-.555-.726-1.072-.726h-1.02v1.53h.895z"/>
          <path fill="#cc2131" d="M168.82 88.17c0-2.458 1.996-4.271 4.352-4.271 2.336 0 4.326 1.814 4.326 4.271 0 2.483-1.99 4.295-4.326 4.295-2.356 0-4.352-1.811-4.352-4.295zm4.352 3.581c1.939 0 3.465-1.518 3.465-3.581 0-2.026-1.525-3.558-3.465-3.558-1.959 0-3.488 1.532-3.488 3.558 0 2.064 1.529 3.581 3.488 3.581z"/>
        </g>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro twitterButton identityProvider clientId]
 <button id="twitter-login-button" class="twitter login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
       <svg version="1.1" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
         <g>
           <rect class="cls-1" width="400" height="400"></rect>
         </g>
         <g>
           <path class="cls-2" d="M153.62,301.59c94.34,0,145.94-78.16,145.94-145.94,0-2.22,0-4.43-.15-6.63A104.36,104.36,0,0,0,325,122.47a102.38,102.38,0,0,1-29.46,8.07,51.47,51.47,0,0,0,22.55-28.37,102.79,102.79,0,0,1-32.57,12.45,51.34,51.34,0,0,0-87.41,46.78A145.62,145.62,0,0,1,92.4,107.81a51.33,51.33,0,0,0,15.88,68.47A50.91,50.91,0,0,1,85,169.86c0,.21,0,.43,0,.65a51.31,51.31,0,0,0,41.15,50.28,51.21,51.21,0,0,1-23.16.88,51.35,51.35,0,0,0,47.92,35.62,102.92,102.92,0,0,1-63.7,22A104.41,104.41,0,0,1,75,278.55a145.21,145.21,0,0,0,78.62,23"></path>
           <rect class="cls-3" width="400" height="400"></rect>
         </g>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro openIDConnectButton identityProvider clientId]
 <button class="openid login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="OpenID Connect Logo" alt="OpenID Connect Logo"/>
       [#else]
         <svg version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
           <g id="g2189">
             <g id="g2202">
               <path class="cls-1" d="M87.57,39.57c-8.9-5.55-21.38-9-34.95-9C25.18,30.59,3,44.31,3,61.17,3,76.64,21.46,89.34,45.46,91.52v-8.9c-16.12-2-28.24-10.87-28.24-21.45,0-12,15.84-21.9,35.4-21.9,9.78,0,18.6,2.41,24.95,6.43l-9,5.62H96.84V33.8Z"></path>
               <path class="cls-2" d="M45.46,15.41v76l14.23-8.9V6.22Z"></path>
             </g>
           </g>
         </svg>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro samlv2Button identityProvider clientId]
 <button class="samlv2 login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="SAML Login" alt="SAML Login"/>
       [#else]
         <img src="/images/identityProviders/samlv2.svg" title="SAML 2 Logo" alt="SAML 2 Logo"/>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro sonypsnButton identityProvider clientId]
<button id="sonypsn-login-button" class="sonypsn login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="-6.003495 -7.75 52.03029 46.5">
        <path fill="#0070d1" d="M.81 22.6c-1.5 1-1 2.9 2.2 3.8 3.3 1.1 6.9 1.4 10.4.8.2 0 .4-.1.5-.1v-3.4l-3.4 1.1c-1.3.4-2.6.5-3.9.2-1-.3-.8-.9.4-1.4l6.9-2.4v-3.7l-9.6 3.3c-1.2.4-2.4 1-3.5 1.8zm23.2-15v9.7c4.1 2 7.3 0 7.3-5.2 0-5.3-1.9-7.7-7.4-9.6-2.9-1-5.9-1.9-8.9-2.5v28.9l7 2.1V6.7c0-1.1 0-1.9.8-1.6 1.1.3 1.2 1.4 1.2 2.5zm13 12.7c-2.9-1-6-1.4-9-1.1-1.6.1-3.1.5-4.5 1l-.3.1v3.9l6.5-2.4c1.3-.4 2.6-.5 3.9-.2 1 .3.8.9-.4 1.4l-10 3.7v3.8l13.8-5.1c1-.4 1.9-.9 2.7-1.7.7-1 .4-2.4-2.7-3.4z"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro steamButton identityProvider clientId]
<button id="steam-login-button" class="steam login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect width="32" height="32" rx="1.6" fill="#1A1A19"/>
      <path d="M15.9818 6.40002C10.93 6.40002 6.79146 10.2886 6.39844 15.23L11.5527 17.3574C11.9893 17.0589 12.5173 16.8851 13.0847 16.8851C13.1359 16.8851 13.1864 16.8864 13.2362 16.8892L15.5286 13.5721V13.5256C15.5286 11.5296 17.1554 9.90531 19.1551 9.90531C21.1548 9.90531 22.7815 11.5296 22.7815 13.5256C22.7815 15.5216 21.1548 17.1465 19.1551 17.1465C19.1274 17.1465 19.1004 17.1459 19.0727 17.1452L15.8033 19.4731C15.8054 19.5163 15.8068 19.5594 15.8068 19.6018C15.8068 21.1009 14.5855 22.3199 13.0847 22.3199C11.7672 22.3199 10.665 21.3808 10.4159 20.1378L6.72919 18.6162C7.87089 22.6458 11.5797 25.6 15.9818 25.6C21.2932 25.6 25.5984 21.3014 25.5984 16C25.5984 10.6979 21.2932 6.40002 15.9818 6.40002ZM12.4248 20.9664L11.2437 20.4791C11.4527 20.9144 11.8152 21.2786 12.2961 21.4784C13.3354 21.911 14.5339 21.4189 14.967 20.3805C15.1767 19.8781 15.1781 19.3236 14.9705 18.8199C14.7629 18.3161 14.3706 17.9232 13.8675 17.7137C13.3673 17.5063 12.8317 17.5138 12.3612 17.6911L13.5818 18.1949C14.3484 18.5139 14.711 19.3928 14.3913 20.158C14.0723 20.9233 13.1915 21.2854 12.4248 20.9664ZM21.5716 13.5257C21.5716 12.1957 20.4873 11.1128 19.1554 11.1128C17.8227 11.1128 16.7384 12.1957 16.7384 13.5257C16.7384 14.8556 17.8227 15.9378 19.1554 15.9378C20.4873 15.9378 21.5716 14.8556 21.5716 13.5257ZM17.3438 13.5215C17.3438 12.5208 18.1569 11.7097 19.1588 11.7097C20.1614 11.7097 20.9745 12.5208 20.9745 13.5215C20.9745 14.5223 20.1614 15.3334 19.1588 15.3334C18.1569 15.3334 17.3438 14.5223 17.3438 13.5215Z" fill="white"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
</button>
[/#macro]

[#macro twitchButton identityProvider clientId]
<button id="twitch-login-button" class="twitch login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
        <rect width="32" height="32" rx="2" fill="#8956FB"/>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M19.9071 19.9628L22.5124 17.3576V9.17195H10.233V19.9628H13.5819V22.195L15.8145 19.9628H19.9071ZM8 10.6605L8.74408 7.68359H24V18.1029L18.0466 24.0555H15.0702L13.2092 25.9164H11.3492V24.0555H8V10.6605ZM15.8139 16.6144H14.3255V12.1485H15.8139V16.6144ZM19.9066 16.6144H18.4183V12.1485H19.9066V16.6144Z" fill="white"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
</button>
[/#macro]

[#macro xboxButton identityProvider clientId]
<button id="xbox-login-button" class="xbox login-button flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
    <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
      <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect width="32" height="32" rx="2" fill="#107C10"/>
      <path d="M15.0411 25.566C13.562 25.4243 12.0647 24.8932 10.7784 24.0539C9.7006 23.3509 9.45736 23.0615 9.45736 22.4847C9.45736 21.3258 10.7316 19.2958 12.9118 16.9821C14.1496 15.6678 15.8741 14.128 16.0605 14.1695C16.4233 14.2505 19.3221 17.0781 20.4075 18.4094C22.1236 20.5138 22.9122 22.2374 22.5114 23.0057C22.2068 23.5897 20.3162 24.7314 18.9276 25.1699C17.7828 25.5314 16.2794 25.6845 15.0411 25.566ZM8.00151 21.2799C7.10577 19.9057 6.65321 18.5529 6.43497 16.5963C6.36266 15.9503 6.3881 15.581 6.59854 14.2545C6.8603 12.6032 7.80134 10.6908 8.93273 9.51475C9.41429 9.01489 9.45714 9.0015 10.0445 9.20011C10.7563 9.44111 11.5173 9.96686 12.6978 11.0344L13.3873 11.6579L13.0102 12.1198C11.2633 14.2644 9.41965 17.3059 8.72564 19.1871C8.34851 20.2092 8.19676 21.2357 8.35967 21.663C8.46901 21.9518 8.36859 21.8442 8.00039 21.2805L8.00151 21.2799ZM23.7234 21.5135C23.8119 21.0815 23.6999 20.2884 23.4377 19.4882C22.8698 17.7554 20.971 14.5319 19.2275 12.3401L18.6785 11.6501L19.2726 11.1049C20.0478 10.3931 20.586 9.96686 21.1671 9.60469C21.6253 9.31905 22.2802 9.06622 22.5618 9.06622C22.7352 9.06622 23.3464 9.7022 23.8396 10.394C24.6037 11.4651 25.1656 12.7661 25.4503 14.1184C25.6344 14.9932 25.6498 16.8632 25.48 17.7357C25.3394 18.4516 25.0449 19.3795 24.7592 20.009C24.5428 20.4805 24.0094 21.3966 23.7751 21.6947C23.6546 21.848 23.6546 21.8478 23.7216 21.5171L23.7234 21.5135ZM15.1996 8.73907C14.3949 8.3307 13.1537 7.8922 12.4681 7.77393C12.228 7.73265 11.8181 7.70922 11.5577 7.72261C10.9918 7.75117 11.017 7.72171 11.9243 7.29304C12.6786 6.93666 13.3079 6.72712 14.1626 6.5477C15.1232 6.34575 16.9297 6.34352 17.8752 6.54279C18.8961 6.75814 20.0987 7.20556 20.7762 7.62286L20.9779 7.74648L20.516 7.72328C19.5975 7.67686 18.259 8.04797 16.8219 8.74688C16.3885 8.95799 16.0118 9.12624 15.9842 9.12178C15.9567 9.11642 15.6035 8.94437 15.1987 8.73907H15.1996Z" fill="white"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
</button>
[/#macro]

[#macro alternativeLogins clientId identityProviders passwordlessEnabled bootstrapWebauthnEnabled=false idpRedirectState="" federatedCSRFToken=""]
  [#if identityProviders?has_content || passwordlessEnabled || bootstrapWebauthnEnabled]
    <div class="flex flex-col mt-6 w-full text-white max-md:max-w-full">
      <div class="self-start text-base tracking-wide text-center max-md:max-w-full text-center w-full">
        <p>Or, log in with a game account</p>
      </div>
      <div class="grid grid-cols-2 gap-2 mt-6 w-full text-sm font-semibold leading-none max-md:px-5 max-md:max-w-full">
        [#if identityProviders["Apple"]?has_content]
          [@appleButton identityProvider=identityProviders["Apple"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["EpicGames"]?has_content]
            [@epicButton identityProvider=identityProviders["EpicGames"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Facebook"]?has_content]
          [@facebookButton identityProvider=identityProviders["Facebook"][0] clientId=clientId /]
        [/#if]

        [#if identityProviders["Google"]?has_content]
          [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId idpRedirectState=idpRedirectState/]
        [/#if]

        [#if identityProviders["LinkedIn"]?has_content]
          [@linkedInBottom identityProvider=identityProviders["LinkedIn"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Nintendo"]?has_content]
          [@nintendoButton identityProvider=identityProviders["Nintendo"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["OpenIDConnect"]?has_content]
          [#list identityProviders["OpenIDConnect"] as identityProvider]
            [@openIDConnectButton identityProvider=identityProvider clientId=clientId/]
          [/#list]
        [/#if]

        [#if identityProviders["SAMLv2"]?has_content]
          [#list identityProviders["SAMLv2"] as identityProvider]
            [@samlv2Button identityProvider=identityProvider clientId=clientId/]
          [/#list]
        [/#if]

        [#if identityProviders["SonyPSN"]?has_content]
          [@sonypsnButton identityProvider=identityProviders["SonyPSN"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Steam"]?has_content]
            [@steamButton identityProvider=identityProviders["Steam"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Twitch"]?has_content]
            [@twitchButton identityProvider=identityProviders["Twitch"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Twitter"]?has_content]
            [@twitterButton identityProvider=identityProviders["Twitter"][0] clientId=clientId/]
        [/#if]

        [#if identityProviders["Xbox"]?has_content]
            [@xboxButton identityProvider=identityProviders["Xbox"][0] clientId=clientId/]
        [/#if]
      </div>

      [#if passwordlessEnabled]
      <div class="form-row push-less-top">
        [@link url = "/oauth2/passwordless"]
          <div class="magic login-button">
            <div>
              <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
                <i class="fa fa-link"></i>
              </div>
              <div class="text">${theme.message('passwordless-button-text')}</div>
            </div>
          </div>
        [/@link]
      </div>
      [/#if]

      [#if bootstrapWebauthnEnabled]
      <div class="form-row push-less-top">
        [@link url = "/oauth2/webauthn"]
          <div class="magic login-button">
            <div>
              <div class="icon object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square">
                <svg xmlns="http://www.w3.org/2000/svg" width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                  <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#FFF" stroke="none">
                    <path d="M923 4595 c-187 -51 -349 -214 -398 -402 -12 -44 -15 -122 -15 -348 0 -261 2 -294 19 -331 51 -112 193 -135 276 -43 19 21 37 49 40 61 2 13 6 160 7 328 3 338 5 345 72 386 28 17 58 19 336 22 168 1 315 5 328 7 12 3 40 21 61 40 92 83 69 225 -43 276 -37 17 -70 19 -336 18 -221 0 -308 -4 -347 -14z"/>
                    <path d="M3514 4591 c-112 -51 -135 -193 -43 -276 21 -19 49 -37 61 -40 13 -2 160 -6 328 -7 338 -3 345 -5 386 -72 17 -28 19 -58 22 -336 1 -168 5 -315 7 -328 3 -12 21 -40 40 -61 83 -92 225 -69 276 43 17 37 19 70 19 331 0 320 -5 355 -61 468 -42 82 -154 194 -236 236 -113 56 -148 61 -468 61 -261 0 -294 -2 -331 -19z"/>
                    <path d="M1640 3229 c-14 -6 -36 -20 -48 -32 -49 -46 -52 -62 -52 -294 0 -193 2 -222 19 -253 48 -91 175 -117 252 -53 61 51 69 86 69 298 0 105 -4 206 -10 224 -11 39 -51 86 -92 107 -31 16 -101 17 -138 3z"/>
                    <path d="M2500 3233 c-36 -15 -72 -48 -90 -83 -19 -37 -20 -60 -20 -398 l0 -359 -31 -7 c-79 -15 -139 -89 -139 -170 0 -48 31 -109 72 -138 47 -33 153 -33 220 0 70 35 140 103 179 174 l34 63 3 397 c3 382 2 399 -17 437 -30 57 -73 84 -140 88 -31 1 -63 0 -71 -4z"/>
                    <path d="M3335 3222 c-44 -29 -74 -65 -85 -103 -6 -19 -10 -119 -10 -224 0 -212 8 -247 69 -298 77 -64 204 -38 252 53 17 31 19 60 19 256 0 213 -1 222 -22 254 -37 54 -71 73 -135 77 -45 3 -65 0 -88 -15z"/>
                    <path d="M2006 1870 c-34 -11 -82 -54 -102 -92 -19 -37 -18 -106 4 -148 34 -69 212 -173 387 -226 84 -26 102 -28 265 -28 163 0 181 2 265 28 175 53 353 157 387 226 70 139 -75 297 -213 231 -24 -11 -72 -38 -107 -60 -99 -62 -169 -83 -302 -88 -165 -7 -265 22 -421 122 -60 39 -114 50 -163 35z"/>
                    <path d="M627 1696 c-50 -18 -76 -42 -98 -91 -17 -36 -19 -70 -19 -330 0 -320 5 -355 61 -468 42 -82 154 -194 236 -236 113 -56 148 -61 468 -61 261 0 294 2 331 19 112 51 135 193 43 276 -21 19 -49 37 -61 40 -13 2 -160 6 -328 7 -435 4 -403 -29 -410 423 -3 217 -9 326 -17 340 -19 33 -66 72 -102 84 -43 14 -57 13 -104 -3z"/>
                    <path d="M4385 1698 c-33 -11 -80 -51 -98 -83 -8 -14 -14 -123 -17 -340 -7 -452 25 -419 -410 -423 -168 -1 -315 -5 -328 -7 -12 -3 -40 -21 -61 -40 -92 -83 -69 -225 43 -276 37 -17 70 -19 331 -19 320 0 355 5 468 61 82 42 194 154 236 236 56 113 61 148 61 468 0 260 -2 294 -19 330 -22 49 -48 73 -98 91 -45 16 -67 16 -108 2z"/>
                  </g>
                </svg>
              </div>
              <div class="text">${theme.message('webauthn-button-text')}</div>
            </div>
          </div>
        [/@link]
      </div>
      [/#if]
    </div>
  [/#if]
[/#macro]

[#-- Below are the helpers for errors and alerts --]

[#macro printErrorAlerts rowClass colClass]
  [#if errorMessages?size > 0]
    [#list errorMessages as m]
      [@alert message=m type="error" icon="exclamation-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro printInfoAlerts rowClass colClass]
  [#if infoMessages?size > 0]
    [#list infoMessages as m]
      [@alert message=m type="info" icon="info-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro alert message type icon includeDismissButton=true rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4"]
<div class="${rowClass}">
  <div class="${colClass}">
    <div class="alert ${type}">
      <i class="fa fa-${icon}"></i>
      <p>
        ${message}
      </p>
      [#if includeDismissButton]
        <a href="#" class="dismiss-button"><i class="fa fa-times-circle"></i></a>
      [/#if]
    </div>
  </div>
</div>
[/#macro]

[#-- Below are the input helpers for hidden, text, buttons, labels and form errors.
     These fields are general purpose and can be used on any form you like. --]

[#-- Hidden Input --]
[#macro hidden name value="" dateTimeFormat=""]
  [#if !value?has_content]
    [#local value=("((" + name + ")!'')")?eval?string/]
  [/#if]
  <input type="hidden" name="${name}" [#if value == ""]value="${value}" [#else]value="${value?string}"[/#if]/>
  [#if dateTimeFormat != ""]
  <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [/#if]
[/#macro]

[#-- Input field of type. --]
[#macro input type name id autocapitalize="none" autocomplete="on" autocorrect="off" autofocus=false spellcheck="false" label="" placeholder="" leftAddon="" required=false tooltip="" disabled=false class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full p-2" dateTimeFormat="" value="" uncheckedValue=""]
<div class="form-row">
  [#if type == "checkbox"]
    [@_input_checkbox name=name value=value uncheckedValue=uncheckedValue label=label tooltip=tooltip]
     [#nested]
    [/@_input_checkbox]
  [#else]
    [@_input_text type=type name=name id=id autocapitalize=autocapitalize autocomplete=autocomplete autocorrect=autocorrect autofocus=autofocus spellcheck=spellcheck label=label placeholder=placeholder leftAddon=leftAddon required=required tooltip=tooltip disabled=disabled class=class dateTimeFormat=dateTimeFormat/]
  [/#if]
  [@errors field=name/]
</div>
[/#macro]

[#macro _input_text type name id autocapitalize autocomplete autocorrect autofocus spellcheck label placeholder leftAddon required tooltip disabled class dateTimeFormat ]
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  [#if leftAddon?has_content]
  <div class="input-addon-group">
    <span class="icon"><i class="fa fa-${leftAddon}"></i></span>
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
  [#if (placeholder?has_content) && (type == "date") && (value == "")]
    [#-- If the value is empty, we want to show the placeholder. This is a workaround for the date picker. --]
    [#assign the_type="text" /]
    [#assign the_class=class + " date-picker" /]
    [#if (fieldMessages[name]![])?size > 0]
      [#assign the_class=the_class + ' outline-red-500 outline-2' /]
    [/#if]
    [#-- it is possible that this element is the first in the form list. We want it to focus on something else so that the placeholder shows. --]
    <input type="text" style="display:none" autofocus="autofocus" />
  [#else ]
    [#assign the_type=type /]
    [#assign the_class=class /]
    [#if (fieldMessages[name]![])?size > 0]
      [#assign the_class=the_class + ' outline-red-500 outline-2' /]
    [/#if]
  [/#if]
  <input id="${id}" type="${the_type}" name="${name}" [#if type != "password"]value="${value}"[/#if] class="${the_class}" autocapitalize="${autocapitalize}" autocomplete="${autocomplete}" autocorrect="${autocorrect}" spellcheck="${spellcheck}" [#if autofocus]autofocus="autofocus"[/#if] placeholder="${placeholder}" [#if disabled]disabled="disabled"[/#if]/>
  [#if dateTimeFormat != ""]
    <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [#elseif type == "date"]
    <input type="hidden" name="${name}@dateTimeFormat" value="yyyy-MM-dd"/>
  [/#if]
  [#if leftAddon?has_content]
  </div>
  [/#if]
[/#macro]

[#macro _input_checkbox name value uncheckedValue label tooltip]
<label>
  [#local actualValue = ("((" + name + ")!'')")?eval/]
  [#local checked = actualValue?is_boolean?then(actualValue == value?boolean, actualValue == value)/]
  [#if uncheckedValue?has_content]
  <input type="hidden" name="__cb_${name}" value="${uncheckedValue}"/>
  [/#if]
  <input type="checkbox" name=${name} value="${value}" [#if checked]checked=checked[/#if]/>
  &nbsp; ${label?has_content?then(label, theme.message(name))}
  [#nested/]
  [#if tooltip?has_content]
    <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
  [/#if]
</label>
[/#macro]

[#-- Select --]
[#macro select name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="select" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  <label class="select">
    [#local value=("((" + name + ")!'')")?eval/]
    [#if name == "user.timezone" || name == "registration.timezone"]
      <select id="${id}" class="${class}" name="${name}">
        [#list timezones as option]
          [#local selected = value == option/]
          <option value="${option}" [#if selected]selected="selected"[/#if] >${option}</option>
        [/#list]]
      </select>
    [#else]
    <select id="${id}" class="${class}" name="${name}">
      [#list options as option]
        [#local selected = value == option/]
        <option value="${option}" [#if selected]selected="selected"[/#if] >${theme.optionalMessage(option)}</option>
      [/#list]
    </select>
    [/#if]
  </label>
  [@errors field=name/]
</div>
[/#macro]

[#-- Text Area --]
[#macro textarea name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="textarea" placeholder=""]
<div class="form-row">
  <textarea id="${id}" name="${name}" class="${class}">${(name?eval!'')}</textarea>
  [@errors field=name/]
</div>
[/#macro]

[#-- Begin : Used for Advanced Registration.
     The following form controls require a 'field' argument which is only available during registration. --]

[#-- Radio List --]
[#macro radio_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="radio-list" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
  </label>
  [/#compress]
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local checked = value == option/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="radio"><input type="radio" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox"]
<div class="form-row">
   <label class="${class}">
     [#local value=("((" + name + ")!'')")?eval/]
     [#local checked = value?has_content]
     [#if field.type == "consent"]
       [#local checked = consents(field.consentId)??]
     [/#if]
     <input id="${id}" type="checkbox" name="${name}" value="${value}" [#if checked]checked="checked"[/#if]>
       <span class="box"></span>
       <span class="label">${theme.optionalMessage(name)}</span>
   </label>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox-list" options=[]]
<div class="form-row">
  [#if label?has_content][#t/]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if][#t/]
    [#if tooltip?has_content][#t/]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>[#t/]
    [/#if][#t/]
  </label>[#t/]
  [/#if]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local value=("((" + name + ")!'')")?eval/]
      [#local checked = value?is_sequence && value?seq_contains(option)/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="checkbox"><input type="checkbox" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro locale_select field name id autofocus=false label="" required=false tooltip="" class="select"]
  [#-- Note: This is a simple imlementation that does not support selecting more than one locale.
             You may wish to use a multi-select or some other JavaScript widget to allow for more than one selection and to improve UX --]
  [#local value=("((" + name + ")!'')")?eval/]
  <div class="form-row">
    [#if label?has_content][#t/]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if][#t/]
      [#if tooltip?has_content][#t/]
        <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>[#t/]
      [/#if][#t/]
    </label>[#t/]
    [/#if]
    <label class="select">
      <select name="${name}" id="${id}" class="${class}" [#if autofocus]autofocus="autofocus"[/#if]>
        <option value="">${theme.optionalMessage("none-selected")}</option>
      [#list fusionAuth.locales() as l, n]
        [#local checked = value?is_sequence && value?seq_contains(l)/]
        <option  value="${l}" [#if checked]selected[/#if]>${l.getDisplayName()}</option>
      [/#list]
     </select>
   </label>
   [@errors field=name/]
  </div>
[/#macro]

[#-- End : Used for Advanced Registration. --]

[#macro oauthHiddenFields]
  [@hidden name="captcha_token"/]
  [@hidden name="client_id"/]
  [@hidden name="code_challenge"/]
  [@hidden name="code_challenge_method"/]
  [@hidden name="metaData.device.name"/]
  [@hidden name="metaData.device.type"/]
  [@hidden name="nonce"/]
  [@hidden name="oauth_context"/]
  [@hidden name="pendingIdPLinkId"/]
  [@hidden name="redirect_uri"/]
  [@hidden name="response_mode"/]
  [@hidden name="response_type"/]
  [@hidden name="scope"/]
  [@hidden name="state"/]
  [@hidden name="tenantId"/]
  [@hidden name="timezone"/]
  [@hidden name="user_code"/]
[/#macro]

[#macro errors field]
[#if fieldMessages[field]?has_content]
<span class="error">[#list fieldMessages[field] as message]${message?no_esc}[#if message_has_next], [/#if][/#list]</span>
[/#if]
[/#macro]

[#macro button text color="blue" disabled=false name="" value=""]
<button class="${color} button${disabled?then(' disabled', '')}"[#if disabled] disabled="disabled"[/#if][#if name !=""]name="${name}"[/#if][#if value !=""]value="${value}"[/#if]>${text}</button>
[/#macro]

[#macro link url extraParameters=""]
<a href="${url}?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&nonce=${(nonce?url)!''}&pendingIdPLinkId=${(pendingIdPLinkId)!''}&redirect_uri=${(redirect_uri?url)!''}&response_mode=${(response_mode?url)!''}&response_type=${(response_type?url)!''}&scope=${(scope?url)!''}&state=${(state?url)!''}&timezone=${(timezone?url)!''}&metaData.device.name=${(metaData.device.name?url)!''}&metaData.device.type=${(metaData.device.type?url)!''}${(extraParameters!'')?no_esc}&code_challenge=${(code_challenge?url)!''}&code_challenge_method=${(code_challenge_method?url)!''}&user_code=${(user_code?url)!''}">
[#nested/]
</a>
[/#macro]

[#macro logoutLink redirectURI extraParameters=""]
[#-- Note that in order for the post_logout_redirect_uri to be correctly URL escaped, you must use this syntax for assignment --]
[#local post_logout_redirect_uri]${redirectURI}?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&nonce=${(nonce?url)!''}&pendingIdPLinkId=${(pendingIdPLinkId)!''}&redirect_uri=${(redirect_uri?url)!''}&response_mode=${(response_mode?url)!''}&response_type=${(response_type?url)!''}&scope=${(scope?url)!''}&state=${(state?url)!''}&timezone=${(timezone?url)!''}&metaData.device.name=${(metaData.device.name?url)!''}&metaData.device.type=${(metaData.device.type?url)!''}${(extraParameters?no_esc)!''}&code_challenge=${(code_challenge?url)!''}&code_challenge_method=${(code_challenge_method?url)!''}&user_code=${(user_code?url)!''}[/#local]
<a href="/oauth2/logout?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&post_logout_redirect_uri=${post_logout_redirect_uri?markup_string?url}">[#t]
  [#nested/][#t]
</a>[#t]
[/#macro]

[#macro defaultIfNull text default]
  ${text!default}
[/#macro]

[#macro passwordRules passwordValidationRules]
<div class="font-italic">
  <span>
    ${theme.message('password-constraints-intro')}
  </span>
  <ul>
    <li>${theme.message('password-length-constraint', passwordValidationRules.minLength, passwordValidationRules.maxLength)}</li>
    [#if passwordValidationRules.requireMixedCase]
      <li>${theme.message('password-case-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.requireNonAlpha]
      <li>${theme.message('password-alpha-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.requireNumber]
      <li>${theme.message('password-number-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.rememberPreviousPasswords.enabled]
      <li>${theme.message('password-previous-constraint', passwordValidationRules.rememberPreviousPasswords.count)}</li>
    [/#if]
  </ul>
</div>
[/#macro]

[#macro customField field key autofocus=false placeholder="" label="" leftAddon="false"]
  [#assign fieldId = field.key?replace(".", "_") /]
  [#local leftAddon = (leftAddon == "true")?then(field.data.leftAddon!'info', "") /]

  [#if field.key == "user.preferredLanguages" || field.key == "registration.preferredLanguages"]
    [@locale_select field=field id="${fieldId}" name="${field.key}" required=field.required autofocus=autofocus label=label /]
  [#elseif field.control == "checkbox"]
    [#if field.options?has_content]
      [@checkbox_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
    [#else]
      [@checkbox field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label /]
    [/#if]
  [#elseif field.control == "number"]
    [@input id="${fieldId}" type="number" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder)  /]
  [#elseif field.control == "password"]
    [@input id="${fieldId}" type="password" name="${key}" leftAddon="${leftAddon}" autocomplete="new-password" autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "radio"]
    [@radio_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "select"]
    [@select id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "textarea"]
    [@textarea id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "text"]
    [#if field.type == "date"]
      [@input id="${fieldId}" name="${key}" type="date" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
    [#else]
      [@input id="${fieldId}" type="text" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
    [/#if]
  [/#if]
[/#macro]

[#function display object propertyName default="\x2013" ]
  [#assign value=("((object." + propertyName + ")!'')")?eval/]
  [#-- ?has_content is false for boolean types, check it first --]
  [#if value?has_content]
    [#if value?is_number]
      [#return value?string('#,###')]
    [#else]
      [#return (value == default?is_markup_output?then(default?markup_string, default))?then(value, value?string)]
    [/#if]
  [#else]
    [#return default]
  [/#if]
[/#function]

[#macro passwordField field showCurrentPasswordField=false]
  [#-- Render checkbox used to determine whether the form submit should update password--]
  <div class="form-row">
    <label for="editPasswordOption"> ${theme.optionalMessage("change-password")} </label>
    <input type="hidden" name="__cb_editPasswordOption" value="useExisting">
    <label class="toggle">
      <input id="editPasswordOption" type="checkbox" name="editPasswordOption" value="update" data-slide-open="password-fields" [#if editPasswordOption == "update"]checked[/#if]>
      <span class="rail"></span>
      <span class="pin"></span>
    </label>
  </div>
  <div id="password-fields" class="slide-open ${(editPasswordOption == "update")?then('open', '')}">
    [#-- See if the application requires the current password --]
    [#if showCurrentPasswordField]
      [@customField field=field key="currentPassword" autofocus=false label=theme.optionalMessage("current-password")/]
    [/#if]

    [#-- Show the Password Validation Rules if there is a field error for 'user.password' --]
    [#if (fieldMessages?keys?seq_contains("user.password")!false) && passwordValidationRules??]
      [@passwordRules passwordValidationRules/]
    [/#if]

    [#-- Render password field--]
    [@customField field=field key=field.key autofocus=false placeholder=field.key label=theme.optionalMessage(field.key) leftAddon="false"/]

    [#-- Render confirm if set to true on the field     --]
    [#if field.confirm]
      [@customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
    [/#if]
  </div>
[/#macro]

[#macro captchaScripts showCaptcha captchaMethod siteKey=""]
  [#if showCaptcha]
    [#if captchaMethod == "GoogleRecaptchaV2"]
      <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    [/#if]
    [#if captchaMethod == "GoogleRecaptchaV3"]
      <script src="https://www.google.com/recaptcha/api.js?render=${siteKey}"></script>
    [/#if]
    [#if captchaMethod == "HCaptcha" || captchaMethod == "HCaptchaEnterprise"]
      <script src="https://hcaptcha.com/1/api.js" async defer></script>
    [/#if]
    <script src="${request.contextPath}/js/oauth2/Captcha.js?version=${version}"></script>
    <script data-captcha-method="${captchaMethod!''}" data-site-key="${siteKey!''}">
      Prime.Document.onReady(function() {
        new FusionAuth.OAuth2.Captcha();
      });
    </script>
  [/#if]
[/#macro]

[#macro captchaBadge showCaptcha captchaMethod siteKey=""]
  [#-- If you want to remove captcha from the page, also ensure you disable it in the tenant configruation. --]
  [#if showCaptcha]
    [#if captchaMethod == "GoogleRecaptchaV2"]
      <div class="g-recaptcha" data-sitekey="${siteKey!''}"
        [#-- To use the invisible mode, un-comment the following two data- attributes. For more information see: https://developers.google.com/recaptcha/docs/invisible --]
        [#--
        data-size="invisible"
        data-callback="reCaptchaV2InvisibleCallback"
        --]
      ></div>
    [#elseif captchaMethod == "GoogleRecaptchaV3"]
      [#-- This is the replacement Terms and Conditions messaging that is required by Google when hiding the
           standard badge. If you want to remove this you will also need to remove or edit the CSS above. --]
      <div class="grecaptcha-msg">
        ${theme.message('captcha-google-branding')?no_esc}
      </div>
    [#elseif captchaMethod == "HCaptcha" || captchaMethod == "HCaptchaEnterprise"]
      <div class="h-captcha" data-sitekey="${siteKey!''}"></div>
    [/#if]
    [@errors field="captcha_token"/]
  [/#if]
[/#macro]

[#macro scopeConsentField application scope type]
  [#-- Resolve the consent message and detail for the provided scope --]
  [#if type != "unknown"]
    [#local scopeMessage = resolveScopeMessaging('message', application, scope.name, scope.defaultConsentMessage!scope.name) /]
    [#local scopeDetail = resolveScopeMessaging('detail', application, scope.name, scope.defaultConsentDetail!'') /]
  [/#if]

  [#if type == "required"]
    [#-- Required scopes should use a hidden form field with a value of "true". The user cannot change this selection, --]
    [#-- but there should be a display element to inform the user that they must consent to the scopes to continue. --]
    <div class="form-row consent-item col-lg-offset-0">
      [@hidden name="scopeConsents['${scope.name}']" value="true" /]
      <i class="fa fa-check"></i>
      <span>
        ${scopeMessage}
        [#if scopeDetail?has_content]
          <i class="fa fa-info-circle" data-tooltip="${scopeDetail}"></i>
        [/#if]
      </span>
    </div>
  [#elseif type == "optional"]
    [#-- Optional scopes should render a checkbox to allow a user to change their selection. The available values should be "true" and "false" --]
    <div class="consent-item col-lg-offset-0">
      [@input type="checkbox" name="scopeConsents['${scope.name}']" id="${scope.name}" label=scopeMessage value="true" uncheckedValue="false" tooltip=scopeDetail /]
    </div>
  [#elseif type == "unknown"]
    [#-- Unknown scopes and the reserved "openid" and "offline_access" scopes are considered required and do not have an associated display element. --]
    [@hidden name="scopeConsents['${scope}']" value="true" /]
  [/#if]
[/#macro]

[#function resolveScopeMessaging messageType application scopeName default]
  [#-- Application specific, tenant specific, not application/tenant specific, then default --]
  [#local message = theme.optionalMessage("[{application}${application.id}]{scope-${messageType}}${scopeName}") /]
  [#local resolvedMessage = message != "[{application}${application.id}]{scope-${messageType}}${scopeName}" /]
  [#if !resolvedMessage]
     [#local message = theme.optionalMessage("[{tenant}${application.tenantId}]{scope-${messageType}}${scopeName}") /]
     [#local resolvedMessage = message != "[{tenant}${application.tenantId}]{scope-${messageType}}${scopeName}" /]
  [/#if]
  [#if !resolvedMessage]
    [#local message = theme.optionalMessage("{scope-${messageType}}${scopeName}") /]
    [#local resolvedMessage = message != "{scope-${messageType}}${scopeName}" /]
  [/#if]
  [#if !resolvedMessage]
    [#return default /]
  [#else]
    [#return message /]
  [/#if]
[/#function]

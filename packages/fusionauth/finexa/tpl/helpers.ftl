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
  <main class="h-screen flex flex-col items-center justify-center bg-base-200">
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

[#macro main title="finexa pro" login=false]
  [#if login]
    [#assign loginUnderline = "btn-neutral" /]
  [#else]
    [#assign loginUnderline = "btn-accent border-none outline-none shadow-none" /]
  [/#if]
  [#if !login]
    [#assign registerUnderline = "btn-neutral" /]
  [#else]
    [#assign registerUnderline = "btn-accent border-none outline-none shadow-none" /]
  [/#if]

  <section class="flex items-center justify-center p-0 sm:p-12 max-w-[1000px] max-h-[500px] w-full h-full">
    <div class="grid grid-cols-1 lg:grid-cols-2 max-h-screen max-w-full aspect-[2/1]">

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

      <div class="flex flex-col gap-2 items-center">
        <svg width="72" height="72" viewBox="0 0 72 72" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" clip-rule="evenodd" d="M71.7188 35.7186C71.7188 52.0685 60.7337 65.8526 45.7415 70.0929L71.5263 31.9881C71.6536 33.2143 71.7188 34.4588 71.7188 35.7186ZM24.3688 69.501C26.6906 70.3002 29.1206 70.8668 31.6311 71.173L67.2895 18.477C66.082 16.2903 64.6519 14.2437 63.0298 12.3677L24.3688 69.501ZM14.5305 64.2677C5.87645 57.7493 0.281067 47.3874 0.281067 35.7186C0.281067 15.9916 16.273 -0.000244141 35.9999 -0.000244141C42.7807 -0.000244141 49.1202 1.88922 54.5206 5.17036L14.5305 64.2677Z" fill="white"/>
        </svg>
        [#if title?has_content]
        <h2 class="text-4xl font-bold">${title}</h2>
        [/#if]
      </div>
      <div class="relative flex-1 mt-14 w-full max-md:mt-10 max-md:max-w-full flex flex-col gap-2 md:gap-4">
        <div class="flex items-start w-full text-xl tracking-wide leading-snug max-md:max-w-full p-1 bg-accent rounded-lg">
          <div class="flex-1 shrink btn rounded-none min-h-[56px] ${loginUnderline} text-center">
        [@helpers.link url="${request.contextPath}/oauth2/authorize"]
          Sign In
        [/@helpers.link]
          </div>
          <div class="flex-1 shrink btn rounded-none min-h-[56px] ${registerUnderline} text-center">
        [@helpers.link url="${request.contextPath}/oauth2/register"]
          Register
        [/@helpers.link]
          </div>
        </div>
        <main>
          [#nested/]
          <div class="mt-2 md:mt-8 text-center"> 
        [@localSelector/]
          </div>
        </main>
      </div>
      </div>
      [#-- Photo --]
      <div class="hidden lg:flex relative flex-col items-center justify-center p-1 w-full h-full">
        <svg class="w-full h-full" viewBox="0 0 680 880" fill="none" xmlns="http://www.w3.org/2000/svg">
          <g clip-path="url(#clip0_2375_586)">
          <rect width="680" height="880" rx="12" fill="#00113D"/>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M1278 232C1278 656.774 992.607 1014.89 603.108 1125.06L1273 135.096C1276.31 166.946 1278 199.275 1278 232ZM47.8259 1109.69C108.148 1130.46 171.282 1145.18 236.505 1153.13L1162.93 -215.938C1131.56 -272.75 1094.4 -325.923 1052.26 -374.662L47.8259 1109.69ZM-207.781 973.73C-432.624 804.38 -578 535.167 -578 232C-578 -280.52 -162.52 -696 350 -696C526.173 -696 690.881 -646.908 831.189 -561.658L-207.781 973.73Z" fill="#2C4EA5" fill-opacity="0.55"/>
          <rect x="373" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="394.73" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="416.461" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="438.191" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="459.922" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="481.656" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="503.387" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="525.117" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="546.848" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="568.578" y="551" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="373" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
          <rect x="394.73" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="416.461" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="438.191" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="459.922" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="481.656" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="503.387" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="525.117" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="546.848" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="568.578" y="572.73" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="373" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="394.73" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="416.461" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="438.191" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="459.922" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="481.656" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="503.387" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="525.117" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="546.848" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="568.578" y="594.462" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="373" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="394.73" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="416.461" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="438.191" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="459.922" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="481.656" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="503.387" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="525.117" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="546.848" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="568.578" y="616.193" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="373" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="394.73" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="416.461" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="438.191" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="459.922" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="481.656" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="503.387" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="525.117" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
            <rect x="546.848" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="637.924" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="659.654" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="681.386" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="703.116" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="724.848" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="746.578" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="373" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="394.73" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="416.461" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="438.191" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="459.922" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="481.656" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="503.387" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="525.117" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="546.848" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="568.578" y="768.31" width="3.25964" height="3.25964" fill="white" fill-opacity="0.1"/>
                <rect x="280.5" y="138" width="119" height="34" rx="4" fill="#5E86F0"/>
                <path d="M299.837 149.818V160H298.425L293.249 152.533H293.155V160H291.619V149.818H293.04L298.221 157.295H298.315V149.818H299.837ZM302.078 160V149.818H308.461V151.141H303.614V154.243H308.128V155.56H303.614V158.678H308.521V160H302.078ZM312.507 160L309.683 149.818H311.299L313.282 157.703H313.377L315.44 149.818H317.041L319.104 157.708H319.199L321.177 149.818H322.798L319.969 160H318.423L316.28 152.374H316.201L314.058 160H312.507ZM327.904 160V149.818H334.218V151.141H329.44V154.243H333.765V155.56H329.44V160H327.904ZM336.107 160V149.818H342.49V151.141H337.643V154.243H342.157V155.56H337.643V158.678H342.55V160H336.107ZM345.403 160H343.772L347.436 149.818H349.211L352.875 160H351.244L348.366 151.668H348.286L345.403 160ZM345.676 156.013H350.966V157.305H345.676V156.013ZM352.64 151.141V149.818H360.52V151.141H357.343V160H355.812V151.141H352.64ZM368.809 149.818H370.35V156.515C370.35 157.228 370.183 157.859 369.848 158.409C369.513 158.956 369.042 159.387 368.436 159.702C367.829 160.013 367.118 160.169 366.303 160.169C365.491 160.169 364.782 160.013 364.175 159.702C363.569 159.387 363.098 158.956 362.763 158.409C362.429 157.859 362.261 157.228 362.261 156.515V149.818H363.797V156.391C363.797 156.851 363.898 157.261 364.101 157.619C364.306 157.977 364.596 158.258 364.971 158.464C365.345 158.666 365.789 158.767 366.303 158.767C366.82 158.767 367.266 158.666 367.64 158.464C368.018 158.258 368.307 157.977 368.506 157.619C368.708 157.261 368.809 156.851 368.809 156.391V149.818ZM372.583 160V149.818H376.213C377.002 149.818 377.656 149.954 378.176 150.226C378.7 150.498 379.091 150.874 379.35 151.354C379.608 151.832 379.738 152.384 379.738 153.01C379.738 153.633 379.607 154.182 379.345 154.656C379.086 155.126 378.695 155.492 378.172 155.754C377.651 156.016 376.997 156.147 376.208 156.147H373.458V154.825H376.069C376.566 154.825 376.97 154.753 377.282 154.611C377.596 154.468 377.827 154.261 377.973 153.989C378.118 153.718 378.191 153.391 378.191 153.01C378.191 152.625 378.117 152.292 377.968 152.011C377.822 151.729 377.592 151.513 377.277 151.364C376.965 151.212 376.556 151.136 376.049 151.136H374.12V160H372.583ZM377.61 155.406L380.125 160H378.375L375.909 155.406H377.61ZM381.607 160V149.818H387.99V151.141H383.143V154.243H387.657V155.56H383.143V158.678H388.05V160H381.607Z" fill="white"/>
                <path d="M263.097 216H257.824L265.858 192.727H272.199L280.222 216H274.949L269.119 198.045H268.938L263.097 216ZM262.767 206.852H275.222V210.693H262.767V206.852ZM288.551 216.284C287.225 216.284 286.025 215.943 284.949 215.261C283.881 214.572 283.032 213.561 282.403 212.227C281.782 210.886 281.472 209.242 281.472 207.295C281.472 205.295 281.794 203.633 282.438 202.307C283.081 200.973 283.938 199.977 285.006 199.318C286.081 198.652 287.259 198.318 288.54 198.318C289.517 198.318 290.331 198.485 290.983 198.818C291.642 199.144 292.172 199.553 292.574 200.045C292.983 200.53 293.294 201.008 293.506 201.477H293.653V192.727H298.483V216H293.71V213.205H293.506C293.278 213.689 292.956 214.17 292.54 214.648C292.131 215.117 291.597 215.508 290.938 215.818C290.286 216.129 289.491 216.284 288.551 216.284ZM290.085 212.432C290.866 212.432 291.525 212.22 292.062 211.795C292.608 211.364 293.025 210.761 293.312 209.989C293.608 209.216 293.756 208.311 293.756 207.273C293.756 206.235 293.612 205.333 293.324 204.568C293.036 203.803 292.619 203.212 292.074 202.795C291.528 202.379 290.866 202.17 290.085 202.17C289.29 202.17 288.619 202.386 288.074 202.818C287.528 203.25 287.116 203.848 286.835 204.614C286.555 205.379 286.415 206.265 286.415 207.273C286.415 208.288 286.555 209.186 286.835 209.966C287.123 210.739 287.536 211.345 288.074 211.784C288.619 212.216 289.29 212.432 290.085 212.432ZM318.736 198.545L312.634 216H307.179L301.077 198.545H306.19L309.815 211.034H309.997L313.611 198.545H318.736ZM325.722 216.33C324.608 216.33 323.616 216.136 322.744 215.75C321.873 215.356 321.184 214.777 320.676 214.011C320.176 213.239 319.926 212.277 319.926 211.125C319.926 210.155 320.104 209.341 320.46 208.682C320.816 208.023 321.301 207.492 321.915 207.091C322.528 206.689 323.225 206.386 324.006 206.182C324.794 205.977 325.619 205.833 326.483 205.75C327.498 205.644 328.316 205.545 328.938 205.455C329.559 205.356 330.009 205.212 330.29 205.023C330.57 204.833 330.71 204.553 330.71 204.182V204.114C330.71 203.394 330.483 202.837 330.028 202.443C329.581 202.049 328.945 201.852 328.119 201.852C327.248 201.852 326.555 202.045 326.04 202.432C325.525 202.811 325.184 203.288 325.017 203.864L320.54 203.5C320.767 202.439 321.214 201.523 321.881 200.75C322.547 199.97 323.407 199.371 324.46 198.955C325.521 198.53 326.748 198.318 328.142 198.318C329.112 198.318 330.04 198.432 330.926 198.659C331.82 198.886 332.612 199.239 333.301 199.716C333.998 200.193 334.547 200.807 334.949 201.557C335.35 202.299 335.551 203.189 335.551 204.227V216H330.96V213.58H330.824C330.544 214.125 330.169 214.606 329.699 215.023C329.229 215.432 328.665 215.754 328.006 215.989C327.347 216.216 326.585 216.33 325.722 216.33ZM327.108 212.989C327.82 212.989 328.449 212.848 328.994 212.568C329.54 212.28 329.968 211.894 330.278 211.409C330.589 210.924 330.744 210.375 330.744 209.761V207.909C330.593 208.008 330.384 208.098 330.119 208.182C329.862 208.258 329.57 208.33 329.244 208.398C328.919 208.458 328.593 208.515 328.267 208.568C327.941 208.614 327.646 208.655 327.381 208.693C326.813 208.777 326.316 208.909 325.892 209.091C325.468 209.273 325.138 209.519 324.903 209.83C324.669 210.133 324.551 210.511 324.551 210.966C324.551 211.625 324.79 212.129 325.267 212.477C325.752 212.818 326.366 212.989 327.108 212.989ZM344.148 205.909V216H339.307V198.545H343.92V201.625H344.125C344.511 200.61 345.159 199.807 346.068 199.216C346.977 198.617 348.08 198.318 349.375 198.318C350.587 198.318 351.644 198.583 352.545 199.114C353.447 199.644 354.148 200.402 354.648 201.386C355.148 202.364 355.398 203.53 355.398 204.886V216H350.557V205.75C350.564 204.682 350.292 203.848 349.739 203.25C349.186 202.644 348.424 202.341 347.455 202.341C346.803 202.341 346.227 202.481 345.727 202.761C345.235 203.042 344.848 203.451 344.568 203.989C344.295 204.519 344.155 205.159 344.148 205.909ZM367.099 216.341C365.312 216.341 363.774 215.962 362.486 215.205C361.205 214.439 360.221 213.379 359.531 212.023C358.849 210.667 358.509 209.106 358.509 207.341C358.509 205.553 358.853 203.985 359.543 202.636C360.24 201.28 361.228 200.223 362.509 199.466C363.789 198.701 365.312 198.318 367.077 198.318C368.599 198.318 369.933 198.595 371.077 199.148C372.221 199.701 373.126 200.477 373.793 201.477C374.459 202.477 374.827 203.652 374.895 205H370.327C370.198 204.129 369.857 203.428 369.304 202.898C368.759 202.36 368.043 202.091 367.156 202.091C366.406 202.091 365.751 202.295 365.19 202.705C364.637 203.106 364.205 203.693 363.895 204.466C363.584 205.239 363.429 206.174 363.429 207.273C363.429 208.386 363.58 209.333 363.884 210.114C364.194 210.894 364.63 211.489 365.19 211.898C365.751 212.307 366.406 212.511 367.156 212.511C367.709 212.511 368.205 212.398 368.645 212.17C369.092 211.943 369.459 211.614 369.747 211.182C370.043 210.742 370.236 210.216 370.327 209.602H374.895C374.819 210.936 374.455 212.11 373.804 213.125C373.16 214.133 372.27 214.92 371.134 215.489C369.997 216.057 368.652 216.341 367.099 216.341ZM385.949 216.341C384.153 216.341 382.608 215.977 381.312 215.25C380.025 214.515 379.032 213.477 378.335 212.136C377.638 210.788 377.29 209.193 377.29 207.352C377.29 205.557 377.638 203.981 378.335 202.625C379.032 201.269 380.013 200.212 381.278 199.455C382.551 198.697 384.044 198.318 385.756 198.318C386.907 198.318 387.979 198.504 388.972 198.875C389.972 199.239 390.843 199.788 391.585 200.523C392.335 201.258 392.919 202.182 393.335 203.295C393.752 204.402 393.96 205.697 393.96 207.182V208.511H379.222V205.511H389.403C389.403 204.814 389.252 204.197 388.949 203.659C388.646 203.121 388.225 202.701 387.688 202.398C387.157 202.087 386.54 201.932 385.835 201.932C385.1 201.932 384.449 202.102 383.881 202.443C383.32 202.777 382.881 203.227 382.562 203.795C382.244 204.356 382.081 204.981 382.074 205.67V208.523C382.074 209.386 382.233 210.133 382.551 210.761C382.877 211.39 383.335 211.875 383.926 212.216C384.517 212.557 385.218 212.727 386.028 212.727C386.566 212.727 387.059 212.652 387.506 212.5C387.953 212.348 388.335 212.121 388.653 211.818C388.972 211.515 389.214 211.144 389.381 210.705L393.858 211C393.631 212.076 393.165 213.015 392.46 213.818C391.763 214.614 390.862 215.235 389.756 215.682C388.657 216.121 387.388 216.341 385.949 216.341ZM403.551 216.284C402.225 216.284 401.025 215.943 399.949 215.261C398.881 214.572 398.032 213.561 397.403 212.227C396.782 210.886 396.472 209.242 396.472 207.295C396.472 205.295 396.794 203.633 397.438 202.307C398.081 200.973 398.938 199.977 400.006 199.318C401.081 198.652 402.259 198.318 403.54 198.318C404.517 198.318 405.331 198.485 405.983 198.818C406.642 199.144 407.172 199.553 407.574 200.045C407.983 200.53 408.294 201.008 408.506 201.477H408.653V192.727H413.483V216H408.71V213.205H408.506C408.278 213.689 407.956 214.17 407.54 214.648C407.131 215.117 406.597 215.508 405.938 215.818C405.286 216.129 404.491 216.284 403.551 216.284ZM405.085 212.432C405.866 212.432 406.525 212.22 407.062 211.795C407.608 211.364 408.025 210.761 408.312 209.989C408.608 209.216 408.756 208.311 408.756 207.273C408.756 206.235 408.612 205.333 408.324 204.568C408.036 203.803 407.619 203.212 407.074 202.795C406.528 202.379 405.866 202.17 405.085 202.17C404.29 202.17 403.619 202.386 403.074 202.818C402.528 203.25 402.116 203.848 401.835 204.614C401.555 205.379 401.415 206.265 401.415 207.273C401.415 208.288 401.555 209.186 401.835 209.966C402.123 210.739 402.536 211.345 403.074 211.784C403.619 212.216 404.29 212.432 405.085 212.432ZM157.284 248H152.011L160.045 224.727H166.386L174.409 248H169.136L163.307 230.045H163.125L157.284 248ZM156.955 238.852H169.409V242.693H156.955V238.852ZM188.312 240.568V230.545H193.153V248H188.506V244.83H188.324C187.93 245.852 187.275 246.674 186.358 247.295C185.449 247.917 184.339 248.227 183.028 248.227C181.862 248.227 180.835 247.962 179.949 247.432C179.063 246.902 178.369 246.148 177.869 245.17C177.377 244.193 177.127 243.023 177.119 241.659V230.545H181.96V240.795C181.968 241.826 182.244 242.64 182.79 243.239C183.335 243.837 184.066 244.136 184.983 244.136C185.566 244.136 186.112 244.004 186.619 243.739C187.127 243.466 187.536 243.064 187.847 242.534C188.165 242.004 188.32 241.348 188.312 240.568ZM203.457 248.284C202.132 248.284 200.931 247.943 199.855 247.261C198.787 246.572 197.938 245.561 197.31 244.227C196.688 242.886 196.378 241.242 196.378 239.295C196.378 237.295 196.7 235.633 197.344 234.307C197.988 232.973 198.844 231.977 199.912 231.318C200.988 230.652 202.166 230.318 203.446 230.318C204.423 230.318 205.238 230.485 205.889 230.818C206.548 231.144 207.079 231.553 207.48 232.045C207.889 232.53 208.2 233.008 208.412 233.477H208.56V224.727H213.389V248H208.616V245.205H208.412C208.185 245.689 207.863 246.17 207.446 246.648C207.037 247.117 206.503 247.508 205.844 247.818C205.192 248.129 204.397 248.284 203.457 248.284ZM204.991 244.432C205.772 244.432 206.431 244.22 206.969 243.795C207.514 243.364 207.931 242.761 208.219 241.989C208.514 241.216 208.662 240.311 208.662 239.273C208.662 238.235 208.518 237.333 208.23 236.568C207.942 235.803 207.526 235.212 206.98 234.795C206.435 234.379 205.772 234.17 204.991 234.17C204.196 234.17 203.526 234.386 202.98 234.818C202.435 235.25 202.022 235.848 201.741 236.614C201.461 237.379 201.321 238.265 201.321 239.273C201.321 240.288 201.461 241.186 201.741 241.966C202.029 242.739 202.442 243.345 202.98 243.784C203.526 244.216 204.196 244.432 204.991 244.432ZM217.369 248V230.545H222.21V248H217.369ZM219.801 228.295C219.081 228.295 218.464 228.057 217.949 227.58C217.441 227.095 217.188 226.515 217.188 225.841C217.188 225.174 217.441 224.602 217.949 224.125C218.464 223.64 219.081 223.398 219.801 223.398C220.521 223.398 221.134 223.64 221.642 224.125C222.157 224.602 222.415 225.174 222.415 225.841C222.415 226.515 222.157 227.095 221.642 227.58C221.134 228.057 220.521 228.295 219.801 228.295ZM234.043 248.341C232.247 248.341 230.702 247.977 229.406 247.25C228.118 246.515 227.126 245.477 226.429 244.136C225.732 242.788 225.384 241.193 225.384 239.352C225.384 237.557 225.732 235.981 226.429 234.625C227.126 233.269 228.107 232.212 229.372 231.455C230.645 230.697 232.137 230.318 233.849 230.318C235.001 230.318 236.073 230.504 237.065 230.875C238.065 231.239 238.937 231.788 239.679 232.523C240.429 233.258 241.012 234.182 241.429 235.295C241.846 236.402 242.054 237.697 242.054 239.182V240.511H227.315V237.511H237.497C237.497 236.814 237.346 236.197 237.043 235.659C236.74 235.121 236.319 234.701 235.781 234.398C235.251 234.087 234.634 233.932 233.929 233.932C233.194 233.932 232.543 234.102 231.974 234.443C231.414 234.777 230.974 235.227 230.656 235.795C230.338 236.356 230.175 236.981 230.168 237.67V240.523C230.168 241.386 230.327 242.133 230.645 242.761C230.971 243.39 231.429 243.875 232.02 244.216C232.611 244.557 233.312 244.727 234.122 244.727C234.66 244.727 235.152 244.652 235.599 244.5C236.046 244.348 236.429 244.121 236.747 243.818C237.065 243.515 237.308 243.144 237.474 242.705L241.952 243C241.724 244.076 241.259 245.015 240.554 245.818C239.857 246.614 238.955 247.235 237.849 247.682C236.751 248.121 235.482 248.341 234.043 248.341ZM250.054 237.909V248H245.213V230.545H249.827V233.625H250.031C250.418 232.61 251.065 231.807 251.974 231.216C252.884 230.617 253.986 230.318 255.281 230.318C256.493 230.318 257.55 230.583 258.452 231.114C259.353 231.644 260.054 232.402 260.554 233.386C261.054 234.364 261.304 235.53 261.304 236.886V248H256.463V237.75C256.471 236.682 256.198 235.848 255.645 235.25C255.092 234.644 254.33 234.341 253.361 234.341C252.709 234.341 252.134 234.481 251.634 234.761C251.141 235.042 250.755 235.451 250.474 235.989C250.202 236.519 250.062 237.159 250.054 237.909ZM273.006 248.341C271.218 248.341 269.68 247.962 268.392 247.205C267.112 246.439 266.127 245.379 265.438 244.023C264.756 242.667 264.415 241.106 264.415 239.341C264.415 237.553 264.759 235.985 265.449 234.636C266.146 233.28 267.134 232.223 268.415 231.466C269.695 230.701 271.218 230.318 272.983 230.318C274.506 230.318 275.839 230.595 276.983 231.148C278.127 231.701 279.032 232.477 279.699 233.477C280.366 234.477 280.733 235.652 280.801 237H276.233C276.104 236.129 275.763 235.428 275.21 234.898C274.665 234.36 273.949 234.091 273.062 234.091C272.312 234.091 271.657 234.295 271.097 234.705C270.544 235.106 270.112 235.693 269.801 236.466C269.491 237.239 269.335 238.174 269.335 239.273C269.335 240.386 269.487 241.333 269.79 242.114C270.1 242.894 270.536 243.489 271.097 243.898C271.657 244.307 272.312 244.511 273.062 244.511C273.616 244.511 274.112 244.398 274.551 244.17C274.998 243.943 275.366 243.614 275.653 243.182C275.949 242.742 276.142 242.216 276.233 241.602H280.801C280.725 242.936 280.362 244.11 279.71 245.125C279.066 246.133 278.176 246.92 277.04 247.489C275.903 248.057 274.559 248.341 273.006 248.341ZM291.855 248.341C290.06 248.341 288.514 247.977 287.219 247.25C285.931 246.515 284.938 245.477 284.241 244.136C283.545 242.788 283.196 241.193 283.196 239.352C283.196 237.557 283.545 235.981 284.241 234.625C284.938 233.269 285.92 232.212 287.185 231.455C288.457 230.697 289.95 230.318 291.662 230.318C292.813 230.318 293.885 230.504 294.878 230.875C295.878 231.239 296.749 231.788 297.491 232.523C298.241 233.258 298.825 234.182 299.241 235.295C299.658 236.402 299.866 237.697 299.866 239.182V240.511H285.128V237.511H295.31C295.31 236.814 295.158 236.197 294.855 235.659C294.552 235.121 294.132 234.701 293.594 234.398C293.063 234.087 292.446 233.932 291.741 233.932C291.007 233.932 290.355 234.102 289.787 234.443C289.226 234.777 288.787 235.227 288.469 235.795C288.151 236.356 287.988 236.981 287.98 237.67V240.523C287.98 241.386 288.139 242.133 288.457 242.761C288.783 243.39 289.241 243.875 289.832 244.216C290.423 244.557 291.124 244.727 291.935 244.727C292.473 244.727 292.965 244.652 293.412 244.5C293.859 244.348 294.241 244.121 294.56 243.818C294.878 243.515 295.12 243.144 295.287 242.705L299.764 243C299.537 244.076 299.071 245.015 298.366 245.818C297.67 246.614 296.768 247.235 295.662 247.682C294.563 248.121 293.295 248.341 291.855 248.341ZM323.148 231.42C323.057 230.504 322.667 229.792 321.977 229.284C321.288 228.777 320.352 228.523 319.17 228.523C318.367 228.523 317.689 228.636 317.136 228.864C316.583 229.083 316.159 229.39 315.864 229.784C315.576 230.178 315.432 230.625 315.432 231.125C315.417 231.542 315.504 231.905 315.693 232.216C315.89 232.527 316.159 232.795 316.5 233.023C316.841 233.242 317.235 233.436 317.682 233.602C318.129 233.761 318.606 233.898 319.114 234.011L321.205 234.511C322.22 234.739 323.152 235.042 324 235.42C324.848 235.799 325.583 236.265 326.205 236.818C326.826 237.371 327.307 238.023 327.648 238.773C327.996 239.523 328.174 240.383 328.182 241.352C328.174 242.777 327.811 244.011 327.091 245.057C326.379 246.095 325.348 246.902 324 247.477C322.659 248.045 321.042 248.33 319.148 248.33C317.269 248.33 315.633 248.042 314.239 247.466C312.852 246.89 311.769 246.038 310.989 244.909C310.216 243.773 309.811 242.367 309.773 240.693H314.534C314.587 241.473 314.811 242.125 315.205 242.648C315.606 243.163 316.14 243.553 316.807 243.818C317.481 244.076 318.242 244.205 319.091 244.205C319.924 244.205 320.648 244.083 321.261 243.841C321.883 243.598 322.364 243.261 322.705 242.83C323.045 242.398 323.216 241.902 323.216 241.341C323.216 240.818 323.061 240.379 322.75 240.023C322.447 239.667 322 239.364 321.409 239.114C320.826 238.864 320.11 238.636 319.261 238.432L316.727 237.795C314.765 237.318 313.216 236.572 312.08 235.557C310.943 234.542 310.379 233.174 310.386 231.455C310.379 230.045 310.754 228.814 311.511 227.761C312.277 226.708 313.326 225.886 314.659 225.295C315.992 224.705 317.508 224.409 319.205 224.409C320.932 224.409 322.439 224.705 323.727 225.295C325.023 225.886 326.03 226.708 326.75 227.761C327.47 228.814 327.841 230.034 327.864 231.42H323.148ZM339.355 248.341C337.56 248.341 336.014 247.977 334.719 247.25C333.431 246.515 332.438 245.477 331.741 244.136C331.045 242.788 330.696 241.193 330.696 239.352C330.696 237.557 331.045 235.981 331.741 234.625C332.438 233.269 333.42 232.212 334.685 231.455C335.957 230.697 337.45 230.318 339.162 230.318C340.313 230.318 341.385 230.504 342.378 230.875C343.378 231.239 344.249 231.788 344.991 232.523C345.741 233.258 346.325 234.182 346.741 235.295C347.158 236.402 347.366 237.697 347.366 239.182V240.511H332.628V237.511H342.81C342.81 236.814 342.658 236.197 342.355 235.659C342.052 235.121 341.632 234.701 341.094 234.398C340.563 234.087 339.946 233.932 339.241 233.932C338.507 233.932 337.855 234.102 337.287 234.443C336.726 234.777 336.287 235.227 335.969 235.795C335.651 236.356 335.488 236.981 335.48 237.67V240.523C335.48 241.386 335.639 242.133 335.957 242.761C336.283 243.39 336.741 243.875 337.332 244.216C337.923 244.557 338.624 244.727 339.435 244.727C339.973 244.727 340.465 244.652 340.912 244.5C341.359 244.348 341.741 244.121 342.06 243.818C342.378 243.515 342.62 243.144 342.787 242.705L347.264 243C347.037 244.076 346.571 245.015 345.866 245.818C345.17 246.614 344.268 247.235 343.162 247.682C342.063 248.121 340.795 248.341 339.355 248.341ZM358.389 254.909C356.821 254.909 355.476 254.693 354.355 254.261C353.241 253.837 352.355 253.258 351.696 252.523C351.037 251.788 350.609 250.962 350.412 250.045L354.889 249.443C355.026 249.792 355.241 250.117 355.537 250.42C355.832 250.723 356.223 250.966 356.707 251.148C357.2 251.337 357.798 251.432 358.503 251.432C359.556 251.432 360.423 251.174 361.105 250.659C361.795 250.152 362.139 249.299 362.139 248.102V244.909H361.935C361.723 245.394 361.404 245.852 360.98 246.284C360.556 246.716 360.01 247.068 359.344 247.341C358.677 247.614 357.882 247.75 356.957 247.75C355.647 247.75 354.454 247.447 353.378 246.841C352.31 246.227 351.457 245.292 350.821 244.034C350.192 242.769 349.878 241.17 349.878 239.239C349.878 237.261 350.2 235.61 350.844 234.284C351.488 232.958 352.344 231.966 353.412 231.307C354.488 230.648 355.666 230.318 356.946 230.318C357.923 230.318 358.741 230.485 359.401 230.818C360.06 231.144 360.59 231.553 360.991 232.045C361.401 232.53 361.715 233.008 361.935 233.477H362.116V230.545H366.923V248.17C366.923 249.655 366.56 250.898 365.832 251.898C365.105 252.898 364.098 253.648 362.81 254.148C361.529 254.655 360.056 254.909 358.389 254.909ZM358.491 244.114C359.272 244.114 359.931 243.92 360.469 243.534C361.014 243.14 361.431 242.58 361.719 241.852C362.014 241.117 362.162 240.239 362.162 239.216C362.162 238.193 362.018 237.307 361.73 236.557C361.442 235.799 361.026 235.212 360.48 234.795C359.935 234.379 359.272 234.17 358.491 234.17C357.696 234.17 357.026 234.386 356.48 234.818C355.935 235.242 355.522 235.833 355.241 236.591C354.961 237.348 354.821 238.223 354.821 239.216C354.821 240.223 354.961 241.095 355.241 241.83C355.529 242.557 355.942 243.121 356.48 243.523C357.026 243.917 357.696 244.114 358.491 244.114ZM370.776 248V230.545H375.389V233.625H375.594C375.957 232.602 376.563 231.795 377.412 231.205C378.26 230.614 379.276 230.318 380.457 230.318C381.654 230.318 382.673 230.617 383.514 231.216C384.355 231.807 384.916 232.61 385.196 233.625H385.378C385.734 232.625 386.378 231.826 387.31 231.227C388.249 230.621 389.359 230.318 390.639 230.318C392.268 230.318 393.59 230.837 394.605 231.875C395.628 232.905 396.139 234.367 396.139 236.261V248H391.31V237.216C391.31 236.246 391.052 235.519 390.537 235.034C390.022 234.549 389.378 234.307 388.605 234.307C387.726 234.307 387.041 234.587 386.548 235.148C386.056 235.701 385.81 236.432 385.81 237.341V248H381.116V237.114C381.116 236.258 380.87 235.576 380.378 235.068C379.893 234.561 379.253 234.307 378.457 234.307C377.92 234.307 377.435 234.443 377.003 234.716C376.579 234.981 376.241 235.356 375.991 235.841C375.741 236.318 375.616 236.879 375.616 237.523V248H370.776ZM407.918 248.341C406.122 248.341 404.577 247.977 403.281 247.25C401.993 246.515 401.001 245.477 400.304 244.136C399.607 242.788 399.259 241.193 399.259 239.352C399.259 237.557 399.607 235.981 400.304 234.625C401.001 233.269 401.982 232.212 403.247 231.455C404.52 230.697 406.012 230.318 407.724 230.318C408.876 230.318 409.948 230.504 410.94 230.875C411.94 231.239 412.812 231.788 413.554 232.523C414.304 233.258 414.887 234.182 415.304 235.295C415.721 236.402 415.929 237.697 415.929 239.182V240.511H401.19V237.511H411.372C411.372 236.814 411.221 236.197 410.918 235.659C410.615 235.121 410.194 234.701 409.656 234.398C409.126 234.087 408.509 233.932 407.804 233.932C407.069 233.932 406.418 234.102 405.849 234.443C405.289 234.777 404.849 235.227 404.531 235.795C404.213 236.356 404.05 236.981 404.043 237.67V240.523C404.043 241.386 404.202 242.133 404.52 242.761C404.846 243.39 405.304 243.875 405.895 244.216C406.486 244.557 407.187 244.727 407.997 244.727C408.535 244.727 409.027 244.652 409.474 244.5C409.921 244.348 410.304 244.121 410.622 243.818C410.94 243.515 411.183 243.144 411.349 242.705L415.827 243C415.599 244.076 415.134 245.015 414.429 245.818C413.732 246.614 412.83 247.235 411.724 247.682C410.626 248.121 409.357 248.341 407.918 248.341ZM423.929 237.909V248H419.088V230.545H423.702V233.625H423.906C424.293 232.61 424.94 231.807 425.849 231.216C426.759 230.617 427.861 230.318 429.156 230.318C430.368 230.318 431.425 230.583 432.327 231.114C433.228 231.644 433.929 232.402 434.429 233.386C434.929 234.364 435.179 235.53 435.179 236.886V248H430.338V237.75C430.346 236.682 430.073 235.848 429.52 235.25C428.967 234.644 428.205 234.341 427.236 234.341C426.584 234.341 426.009 234.481 425.509 234.761C425.016 235.042 424.63 235.451 424.349 235.989C424.077 236.519 423.937 237.159 423.929 237.909ZM448.278 230.545V234.182H437.767V230.545H448.278ZM440.153 226.364H444.994V242.636C444.994 243.083 445.063 243.432 445.199 243.682C445.335 243.924 445.525 244.095 445.767 244.193C446.017 244.292 446.305 244.341 446.631 244.341C446.858 244.341 447.085 244.322 447.312 244.284C447.54 244.239 447.714 244.205 447.835 244.182L448.597 247.784C448.354 247.86 448.013 247.947 447.574 248.045C447.134 248.152 446.6 248.216 445.972 248.239C444.805 248.284 443.782 248.129 442.903 247.773C442.032 247.417 441.354 246.864 440.869 246.114C440.384 245.364 440.146 244.417 440.153 243.273V226.364ZM456.409 248.33C455.295 248.33 454.303 248.136 453.432 247.75C452.561 247.356 451.871 246.777 451.364 246.011C450.864 245.239 450.614 244.277 450.614 243.125C450.614 242.155 450.792 241.341 451.148 240.682C451.504 240.023 451.989 239.492 452.602 239.091C453.216 238.689 453.913 238.386 454.693 238.182C455.481 237.977 456.307 237.833 457.17 237.75C458.186 237.644 459.004 237.545 459.625 237.455C460.246 237.356 460.697 237.212 460.977 237.023C461.258 236.833 461.398 236.553 461.398 236.182V236.114C461.398 235.394 461.17 234.837 460.716 234.443C460.269 234.049 459.633 233.852 458.807 233.852C457.936 233.852 457.242 234.045 456.727 234.432C456.212 234.811 455.871 235.288 455.705 235.864L451.227 235.5C451.455 234.439 451.902 233.523 452.568 232.75C453.235 231.97 454.095 231.371 455.148 230.955C456.208 230.53 457.436 230.318 458.83 230.318C459.799 230.318 460.727 230.432 461.614 230.659C462.508 230.886 463.299 231.239 463.989 231.716C464.686 232.193 465.235 232.807 465.636 233.557C466.038 234.299 466.239 235.189 466.239 236.227V248H461.648V245.58H461.511C461.231 246.125 460.856 246.606 460.386 247.023C459.917 247.432 459.352 247.754 458.693 247.989C458.034 248.216 457.273 248.33 456.409 248.33ZM457.795 244.989C458.508 244.989 459.136 244.848 459.682 244.568C460.227 244.28 460.655 243.894 460.966 243.409C461.277 242.924 461.432 242.375 461.432 241.761V239.909C461.28 240.008 461.072 240.098 460.807 240.182C460.549 240.258 460.258 240.33 459.932 240.398C459.606 240.458 459.28 240.515 458.955 240.568C458.629 240.614 458.333 240.655 458.068 240.693C457.5 240.777 457.004 240.909 456.58 241.091C456.155 241.273 455.826 241.519 455.591 241.83C455.356 242.133 455.239 242.511 455.239 242.966C455.239 243.625 455.477 244.129 455.955 244.477C456.439 244.818 457.053 244.989 457.795 244.989ZM479.278 230.545V234.182H468.767V230.545H479.278ZM471.153 226.364H475.994V242.636C475.994 243.083 476.063 243.432 476.199 243.682C476.335 243.924 476.525 244.095 476.767 244.193C477.017 244.292 477.305 244.341 477.631 244.341C477.858 244.341 478.085 244.322 478.312 244.284C478.54 244.239 478.714 244.205 478.835 244.182L479.597 247.784C479.354 247.86 479.013 247.947 478.574 248.045C478.134 248.152 477.6 248.216 476.972 248.239C475.805 248.284 474.782 248.129 473.903 247.773C473.032 247.417 472.354 246.864 471.869 246.114C471.384 245.364 471.146 244.417 471.153 243.273V226.364ZM482.432 248V230.545H487.273V248H482.432ZM484.864 228.295C484.144 228.295 483.527 228.057 483.011 227.58C482.504 227.095 482.25 226.515 482.25 225.841C482.25 225.174 482.504 224.602 483.011 224.125C483.527 223.64 484.144 223.398 484.864 223.398C485.583 223.398 486.197 223.64 486.705 224.125C487.22 224.602 487.477 225.174 487.477 225.841C487.477 226.515 487.22 227.095 486.705 227.58C486.197 228.057 485.583 228.295 484.864 228.295ZM499.037 248.341C497.272 248.341 495.745 247.966 494.457 247.216C493.177 246.458 492.188 245.405 491.491 244.057C490.795 242.701 490.446 241.129 490.446 239.341C490.446 237.538 490.795 235.962 491.491 234.614C492.188 233.258 493.177 232.205 494.457 231.455C495.745 230.697 497.272 230.318 499.037 230.318C500.802 230.318 502.325 230.697 503.605 231.455C504.893 232.205 505.885 233.258 506.582 234.614C507.279 235.962 507.628 237.538 507.628 239.341C507.628 241.129 507.279 242.701 506.582 244.057C505.885 245.405 504.893 246.458 503.605 247.216C502.325 247.966 500.802 248.341 499.037 248.341ZM499.06 244.591C499.863 244.591 500.533 244.364 501.071 243.909C501.609 243.447 502.014 242.818 502.287 242.023C502.567 241.227 502.707 240.322 502.707 239.307C502.707 238.292 502.567 237.386 502.287 236.591C502.014 235.795 501.609 235.167 501.071 234.705C500.533 234.242 499.863 234.011 499.06 234.011C498.249 234.011 497.567 234.242 497.014 234.705C496.469 235.167 496.056 235.795 495.776 236.591C495.503 237.386 495.366 238.292 495.366 239.307C495.366 240.322 495.503 241.227 495.776 242.023C496.056 242.818 496.469 243.447 497.014 243.909C497.567 244.364 498.249 244.591 499.06 244.591ZM515.616 237.909V248H510.776V230.545H515.389V233.625H515.594C515.98 232.61 516.628 231.807 517.537 231.216C518.446 230.617 519.548 230.318 520.844 230.318C522.056 230.318 523.113 230.583 524.014 231.114C524.916 231.644 525.616 232.402 526.116 233.386C526.616 234.364 526.866 235.53 526.866 236.886V248H522.026V237.75C522.033 236.682 521.76 235.848 521.207 235.25C520.654 234.644 519.893 234.341 518.923 234.341C518.272 234.341 517.696 234.481 517.196 234.761C516.704 235.042 516.317 235.451 516.037 235.989C515.764 236.519 515.624 237.159 515.616 237.909Z" fill="white"/>
                <circle cx="340.235" cy="491.262" r="145.719" stroke="#95AFF2" stroke-width="76.1931"/>
                <path d="M218.144 411.683C203.202 434.561 194.516 461.897 194.516 491.262C194.516 507.205 197.076 522.549 201.808 536.907" stroke="#001650" stroke-width="76.1931"/>
                <path d="M340.234 345.543C420.713 345.543 485.953 410.784 485.953 491.262C485.953 571.741 420.713 636.982 340.234 636.982C275.332 636.982 220.341 594.552 201.484 535.918" stroke="#63A9FB" stroke-width="76.1931"/>
                <path d="M201.484 535.918C220.341 594.552 275.332 636.981 340.234 636.981C373.076 636.981 403.381 626.116 427.75 607.785" stroke="#2C4EA5" stroke-width="76.1931"/>
                <path d="M340.234 345.543C420.713 345.543 485.954 410.784 485.954 491.262C485.954 538.937 463.06 581.263 427.666 607.849" stroke="#2C609C" stroke-opacity="0.1" stroke-width="119.762"/>
                <path d="M340.234 345.543C420.713 345.543 485.954 410.784 485.954 491.262C485.954 538.937 463.06 581.263 427.666 607.849" stroke="#5E86F0" stroke-width="76.1931"/>
                <path opacity="0.9" d="M468.079 489.107V487.244L473.566 478.576H475.119V481.228H474.172L470.479 487.08V487.181H478.137V489.107H468.079ZM474.248 491.506V488.539L474.273 487.705V478.576H476.483V491.506H474.248ZM484.933 491.752C483.893 491.752 483.001 491.489 482.256 490.963C481.515 490.433 480.945 489.669 480.545 488.671C480.15 487.669 479.952 486.464 479.952 485.054C479.956 483.644 480.156 482.444 480.552 481.455C480.951 480.462 481.522 479.704 482.262 479.182C483.007 478.66 483.898 478.399 484.933 478.399C485.968 478.399 486.859 478.66 487.604 479.182C488.349 479.704 488.919 480.462 489.314 481.455C489.714 482.448 489.914 483.648 489.914 485.054C489.914 486.468 489.714 487.676 489.314 488.677C488.919 489.675 488.349 490.437 487.604 490.963C486.863 491.489 485.973 491.752 484.933 491.752ZM484.933 489.776C485.741 489.776 486.379 489.378 486.846 488.583C487.317 487.783 487.553 486.607 487.553 485.054C487.553 484.027 487.446 483.164 487.231 482.465C487.016 481.766 486.713 481.24 486.322 480.887C485.931 480.529 485.468 480.35 484.933 480.35C484.129 480.35 483.494 480.75 483.026 481.55C482.559 482.345 482.323 483.513 482.319 485.054C482.315 486.085 482.418 486.952 482.629 487.655C482.843 488.358 483.146 488.888 483.538 489.246C483.929 489.599 484.394 489.776 484.933 489.776ZM498.925 489.082V488.4C498.925 487.899 499.03 487.438 499.241 487.017C499.455 486.596 499.767 486.257 500.175 486.001C500.583 485.744 501.078 485.616 501.659 485.616C502.256 485.616 502.757 485.744 503.161 486.001C503.565 486.253 503.87 486.59 504.077 487.011C504.287 487.432 504.392 487.895 504.392 488.4V489.082C504.392 489.582 504.287 490.043 504.077 490.464C503.866 490.885 503.557 491.224 503.149 491.481C502.745 491.737 502.248 491.866 501.659 491.866C501.069 491.866 500.571 491.737 500.162 491.481C499.754 491.224 499.445 490.885 499.234 490.464C499.028 490.043 498.925 489.582 498.925 489.082ZM500.573 488.4V489.082C500.573 489.414 500.653 489.719 500.813 489.997C500.973 490.275 501.255 490.414 501.659 490.414C502.067 490.414 502.347 490.277 502.498 490.003C502.654 489.725 502.732 489.418 502.732 489.082V488.4C502.732 488.063 502.658 487.756 502.511 487.478C502.364 487.196 502.08 487.055 501.659 487.055C501.263 487.055 500.983 487.196 500.819 487.478C500.655 487.756 500.573 488.063 500.573 488.4ZM492.353 481.682V481C492.353 480.495 492.46 480.032 492.675 479.612C492.889 479.191 493.201 478.854 493.609 478.601C494.017 478.345 494.512 478.216 495.093 478.216C495.686 478.216 496.185 478.345 496.589 478.601C496.997 478.854 497.305 479.191 497.511 479.612C497.717 480.032 497.82 480.495 497.82 481V481.682C497.82 482.187 497.715 482.65 497.504 483.071C497.298 483.488 496.991 483.823 496.583 484.075C496.174 484.328 495.678 484.454 495.093 484.454C494.499 484.454 493.998 484.328 493.59 484.075C493.186 483.823 492.879 483.486 492.668 483.065C492.458 482.644 492.353 482.183 492.353 481.682ZM494.013 481V481.682C494.013 482.019 494.091 482.326 494.247 482.604C494.407 482.878 494.689 483.014 495.093 483.014C495.497 483.014 495.775 482.878 495.926 482.604C496.082 482.326 496.16 482.019 496.16 481.682V481C496.16 480.664 496.086 480.356 495.939 480.079C495.791 479.797 495.509 479.656 495.093 479.656C494.693 479.656 494.413 479.797 494.253 480.079C494.093 480.361 494.013 480.668 494.013 481ZM493.072 491.506L501.962 478.576H503.54L494.651 491.506H493.072Z" fill="white"/>
                <path opacity="0.9" d="M185.085 467.819V482.596H182.408V470.423H182.322L178.866 472.631V470.178L182.538 467.819H185.085ZM193.974 482.798C193.012 482.798 192.151 482.617 191.391 482.256C190.631 481.891 190.028 481.391 189.58 480.756C189.138 480.121 188.902 479.394 188.873 478.577H191.471C191.519 479.183 191.781 479.678 192.257 480.063C192.733 480.443 193.306 480.633 193.974 480.633C194.499 480.633 194.965 480.513 195.374 480.272C195.783 480.032 196.105 479.697 196.341 479.269C196.577 478.841 196.692 478.353 196.687 477.805C196.692 477.247 196.574 476.751 196.334 476.318C196.093 475.885 195.764 475.546 195.345 475.301C194.927 475.051 194.446 474.926 193.902 474.926C193.46 474.921 193.024 475.003 192.596 475.171C192.168 475.339 191.829 475.561 191.579 475.835L189.162 475.438L189.934 467.819H198.506V470.055H192.149L191.723 473.973H191.81C192.084 473.651 192.471 473.384 192.971 473.172C193.472 472.956 194.02 472.848 194.617 472.848C195.511 472.848 196.31 473.059 197.012 473.483C197.714 473.901 198.267 474.478 198.672 475.214C199.076 475.95 199.278 476.792 199.278 477.74C199.278 478.716 199.052 479.587 198.599 480.352C198.152 481.112 197.529 481.711 196.731 482.148C195.937 482.581 195.018 482.798 193.974 482.798ZM209.595 479.825V479.046C209.595 478.473 209.716 477.947 209.956 477.466C210.202 476.985 210.557 476.597 211.024 476.304C211.491 476.01 212.056 475.864 212.72 475.864C213.403 475.864 213.975 476.01 214.437 476.304C214.899 476.592 215.247 476.977 215.483 477.458C215.724 477.939 215.844 478.468 215.844 479.046V479.825C215.844 480.397 215.724 480.924 215.483 481.405C215.243 481.886 214.889 482.273 214.422 482.567C213.961 482.86 213.393 483.007 212.72 483.007C212.046 483.007 211.476 482.86 211.01 482.567C210.543 482.273 210.19 481.886 209.949 481.405C209.713 480.924 209.595 480.397 209.595 479.825ZM211.479 479.046V479.825C211.479 480.205 211.57 480.554 211.753 480.871C211.936 481.189 212.258 481.347 212.72 481.347C213.186 481.347 213.506 481.191 213.679 480.878C213.857 480.561 213.946 480.21 213.946 479.825V479.046C213.946 478.661 213.862 478.31 213.694 477.992C213.525 477.67 213.201 477.509 212.72 477.509C212.267 477.509 211.948 477.67 211.76 477.992C211.572 478.31 211.479 478.661 211.479 479.046ZM202.084 471.369V470.589C202.084 470.012 202.207 469.483 202.452 469.002C202.698 468.521 203.054 468.136 203.52 467.848C203.987 467.554 204.552 467.407 205.216 467.407C205.894 467.407 206.464 467.554 206.926 467.848C207.392 468.136 207.744 468.521 207.979 469.002C208.215 469.483 208.333 470.012 208.333 470.589V471.369C208.333 471.946 208.213 472.475 207.972 472.956C207.736 473.432 207.385 473.815 206.919 474.103C206.452 474.392 205.884 474.536 205.216 474.536C204.538 474.536 203.965 474.392 203.499 474.103C203.037 473.815 202.686 473.43 202.445 472.949C202.205 472.468 202.084 471.941 202.084 471.369ZM203.982 470.589V471.369C203.982 471.753 204.071 472.105 204.249 472.422C204.432 472.735 204.754 472.891 205.216 472.891C205.678 472.891 205.995 472.735 206.168 472.422C206.346 472.105 206.435 471.753 206.435 471.369V470.589C206.435 470.205 206.351 469.853 206.183 469.536C206.014 469.214 205.692 469.053 205.216 469.053C204.759 469.053 204.439 469.214 204.256 469.536C204.073 469.858 203.982 470.209 203.982 470.589ZM202.907 482.596L213.066 467.819H214.87L204.711 482.596H202.907Z" fill="white"/>
                <path opacity="0.9" d="M252.157 370.56V368.626L257.287 363.597C257.778 363.101 258.186 362.661 258.514 362.276C258.841 361.892 259.086 361.519 259.25 361.158C259.413 360.797 259.495 360.413 259.495 360.004C259.495 359.537 259.389 359.138 259.177 358.806C258.966 358.469 258.675 358.209 258.304 358.027C257.934 357.844 257.513 357.752 257.042 357.752C256.556 357.752 256.13 357.853 255.765 358.056C255.399 358.253 255.115 358.534 254.913 358.9C254.716 359.265 254.617 359.701 254.617 360.206H252.07C252.07 359.268 252.284 358.452 252.713 357.76C253.141 357.067 253.73 356.531 254.48 356.151C255.235 355.771 256.101 355.581 257.078 355.581C258.069 355.581 258.939 355.766 259.69 356.136C260.44 356.507 261.022 357.014 261.436 357.659C261.854 358.303 262.063 359.039 262.063 359.867C262.063 360.42 261.958 360.963 261.746 361.497C261.534 362.031 261.162 362.623 260.628 363.272C260.099 363.922 259.355 364.708 258.398 365.632L255.851 368.222V368.323H262.287V370.56H252.157ZM270.238 370.841C269.05 370.841 268.03 370.54 267.179 369.939C266.333 369.333 265.681 368.46 265.224 367.32C264.772 366.175 264.546 364.797 264.546 363.186C264.55 361.574 264.779 360.203 265.231 359.073C265.688 357.938 266.34 357.072 267.186 356.475C268.038 355.879 269.055 355.581 270.238 355.581C271.422 355.581 272.439 355.879 273.29 356.475C274.142 357.072 274.794 357.938 275.246 359.073C275.703 360.208 275.931 361.579 275.931 363.186C275.931 364.802 275.703 366.182 275.246 367.327C274.794 368.467 274.142 369.338 273.29 369.939C272.444 370.54 271.426 370.841 270.238 370.841ZM270.238 368.583C271.162 368.583 271.891 368.128 272.425 367.219C272.963 366.305 273.233 364.961 273.233 363.186C273.233 362.012 273.11 361.026 272.865 360.227C272.619 359.429 272.273 358.828 271.826 358.424C271.378 358.015 270.849 357.81 270.238 357.81C269.32 357.81 268.593 358.267 268.059 359.181C267.525 360.09 267.256 361.425 267.251 363.186C267.246 364.364 267.364 365.355 267.605 366.158C267.85 366.962 268.196 367.568 268.644 367.977C269.091 368.381 269.623 368.583 270.238 368.583ZM286.229 367.789V367.01C286.229 366.437 286.349 365.911 286.59 365.43C286.835 364.949 287.191 364.561 287.658 364.268C288.124 363.974 288.69 363.828 289.353 363.828C290.036 363.828 290.609 363.974 291.071 364.268C291.532 364.556 291.881 364.941 292.117 365.422C292.357 365.903 292.478 366.432 292.478 367.01V367.789C292.478 368.361 292.357 368.888 292.117 369.369C291.876 369.85 291.523 370.237 291.056 370.531C290.594 370.824 290.027 370.971 289.353 370.971C288.68 370.971 288.11 370.824 287.643 370.531C287.177 370.237 286.823 369.85 286.583 369.369C286.347 368.888 286.229 368.361 286.229 367.789ZM288.112 367.01V367.789C288.112 368.169 288.204 368.518 288.387 368.835C288.569 369.153 288.892 369.311 289.353 369.311C289.82 369.311 290.14 369.155 290.313 368.842C290.491 368.525 290.58 368.174 290.58 367.789V367.01C290.58 366.625 290.496 366.274 290.327 365.956C290.159 365.634 289.834 365.473 289.353 365.473C288.901 365.473 288.581 365.634 288.394 365.956C288.206 366.274 288.112 366.625 288.112 367.01ZM278.718 359.333V358.553C278.718 357.976 278.841 357.447 279.086 356.966C279.331 356.485 279.687 356.1 280.154 355.812C280.621 355.518 281.186 355.371 281.85 355.371C282.528 355.371 283.098 355.518 283.56 355.812C284.026 356.1 284.377 356.485 284.613 356.966C284.849 357.447 284.967 357.976 284.967 358.553V359.333C284.967 359.91 284.846 360.439 284.606 360.92C284.37 361.396 284.019 361.779 283.552 362.067C283.086 362.356 282.518 362.5 281.85 362.5C281.171 362.5 280.599 362.356 280.132 362.067C279.671 361.779 279.319 361.394 279.079 360.913C278.838 360.432 278.718 359.905 278.718 359.333ZM280.616 358.553V359.333C280.616 359.717 280.705 360.069 280.883 360.386C281.065 360.699 281.388 360.855 281.85 360.855C282.311 360.855 282.629 360.699 282.802 360.386C282.98 360.069 283.069 359.717 283.069 359.333V358.553C283.069 358.169 282.985 357.817 282.816 357.5C282.648 357.178 282.326 357.017 281.85 357.017C281.393 357.017 281.073 357.178 280.89 357.5C280.707 357.822 280.616 358.173 280.616 358.553ZM279.541 370.56L289.7 355.783H291.504L281.344 370.56H279.541Z" fill="white"/>
                <path opacity="0.9" d="M294.837 644.762V642.828L299.967 637.799C300.457 637.304 300.866 636.863 301.193 636.479C301.52 636.094 301.766 635.721 301.929 635.36C302.093 634.999 302.175 634.615 302.175 634.206C302.175 633.739 302.069 633.34 301.857 633.008C301.645 632.671 301.354 632.412 300.984 632.229C300.614 632.046 300.193 631.955 299.721 631.955C299.236 631.955 298.81 632.056 298.444 632.258C298.079 632.455 297.795 632.736 297.593 633.102C297.396 633.467 297.297 633.903 297.297 634.408H294.75C294.75 633.47 294.964 632.655 295.392 631.962C295.82 631.269 296.41 630.733 297.16 630.353C297.915 629.973 298.781 629.783 299.757 629.783C300.748 629.783 301.619 629.968 302.369 630.338C303.12 630.709 303.702 631.216 304.115 631.861C304.534 632.505 304.743 633.241 304.743 634.069C304.743 634.622 304.637 635.165 304.426 635.699C304.214 636.233 303.841 636.825 303.307 637.474C302.778 638.124 302.035 638.91 301.078 639.834L298.531 642.424V642.525H304.967V644.762H294.837ZM312.593 644.964C311.631 644.964 310.77 644.783 310.01 644.423C309.25 644.057 308.647 643.557 308.199 642.922C307.757 642.287 307.521 641.561 307.492 640.743H310.09C310.138 641.349 310.4 641.844 310.876 642.229C311.352 642.609 311.925 642.799 312.593 642.799C313.118 642.799 313.584 642.679 313.993 642.438C314.402 642.198 314.724 641.864 314.96 641.435C315.196 641.007 315.311 640.519 315.306 639.971C315.311 639.413 315.193 638.917 314.953 638.484C314.712 638.052 314.383 637.712 313.964 637.467C313.546 637.217 313.065 637.092 312.521 637.092C312.079 637.087 311.643 637.169 311.215 637.337C310.787 637.506 310.448 637.727 310.198 638.001L307.781 637.604L308.553 629.985H317.125V632.222H310.768L310.342 636.139H310.429C310.703 635.817 311.09 635.55 311.59 635.339C312.091 635.122 312.639 635.014 313.236 635.014C314.13 635.014 314.929 635.226 315.631 635.649C316.333 636.067 316.886 636.645 317.291 637.381C317.695 638.116 317.897 638.958 317.897 639.906C317.897 640.882 317.671 641.753 317.218 642.518C316.771 643.278 316.148 643.877 315.35 644.314C314.556 644.747 313.637 644.964 312.593 644.964ZM328.214 641.991V641.212C328.214 640.639 328.335 640.113 328.575 639.632C328.82 639.151 329.176 638.763 329.643 638.47C330.11 638.177 330.675 638.03 331.339 638.03C332.022 638.03 332.594 638.177 333.056 638.47C333.518 638.759 333.866 639.143 334.102 639.624C334.343 640.105 334.463 640.635 334.463 641.212V641.991C334.463 642.563 334.343 643.09 334.102 643.571C333.862 644.052 333.508 644.439 333.041 644.733C332.58 645.026 332.012 645.173 331.339 645.173C330.665 645.173 330.095 645.026 329.629 644.733C329.162 644.439 328.808 644.052 328.568 643.571C328.332 643.09 328.214 642.563 328.214 641.991ZM330.098 641.212V641.991C330.098 642.371 330.189 642.72 330.372 643.037C330.555 643.355 330.877 643.513 331.339 643.513C331.805 643.513 332.125 643.357 332.298 643.044C332.476 642.727 332.565 642.376 332.565 641.991V641.212C332.565 640.827 332.481 640.476 332.313 640.158C332.144 639.836 331.82 639.675 331.339 639.675C330.886 639.675 330.567 639.836 330.379 640.158C330.191 640.476 330.098 640.827 330.098 641.212ZM320.703 633.535V632.756C320.703 632.178 320.826 631.649 321.071 631.168C321.317 630.687 321.673 630.302 322.139 630.014C322.606 629.72 323.171 629.574 323.835 629.574C324.513 629.574 325.083 629.72 325.545 630.014C326.011 630.302 326.362 630.687 326.598 631.168C326.834 631.649 326.952 632.178 326.952 632.756V633.535C326.952 634.112 326.831 634.641 326.591 635.122C326.355 635.598 326.004 635.981 325.538 636.269C325.071 636.558 324.503 636.702 323.835 636.702C323.157 636.702 322.584 636.558 322.118 636.269C321.656 635.981 321.305 635.596 321.064 635.115C320.824 634.634 320.703 634.107 320.703 633.535ZM322.601 632.756V633.535C322.601 633.92 322.69 634.271 322.868 634.588C323.051 634.901 323.373 635.057 323.835 635.057C324.297 635.057 324.614 634.901 324.787 634.588C324.965 634.271 325.054 633.92 325.054 633.535V632.756C325.054 632.371 324.97 632.02 324.802 631.702C324.633 631.38 324.311 631.219 323.835 631.219C323.378 631.219 323.058 631.38 322.875 631.702C322.692 632.024 322.601 632.376 322.601 632.756ZM321.526 644.762L331.685 629.985H333.489L323.33 644.762H321.526Z" fill="white"/>
                <path d="M219.571 739V721.545H225.468C226.832 721.545 227.951 721.778 228.826 722.244C229.701 722.705 230.349 723.338 230.77 724.145C231.19 724.952 231.4 725.869 231.4 726.898C231.4 727.926 231.19 728.838 230.77 729.634C230.349 730.429 229.704 731.054 228.835 731.509C227.966 731.957 226.855 732.182 225.502 732.182H220.73V730.273H225.434C226.366 730.273 227.116 730.136 227.684 729.864C228.258 729.591 228.673 729.205 228.929 728.705C229.19 728.199 229.321 727.597 229.321 726.898C229.321 726.199 229.19 725.588 228.929 725.065C228.667 724.543 228.25 724.139 227.676 723.855C227.102 723.565 226.343 723.42 225.4 723.42H221.684V739H219.571ZM227.787 731.159L232.082 739H229.627L225.4 731.159H227.787ZM239.998 739.273C238.736 739.273 237.648 738.994 236.733 738.438C235.824 737.875 235.123 737.091 234.628 736.085C234.14 735.074 233.895 733.898 233.895 732.557C233.895 731.216 234.14 730.034 234.628 729.011C235.123 727.983 235.81 727.182 236.691 726.608C237.577 726.028 238.611 725.739 239.793 725.739C240.475 725.739 241.148 725.852 241.813 726.08C242.478 726.307 243.083 726.676 243.628 727.188C244.174 727.693 244.608 728.364 244.932 729.199C245.256 730.034 245.418 731.062 245.418 732.284V733.136H235.327V731.398H243.373C243.373 730.659 243.225 730 242.929 729.42C242.64 728.841 242.225 728.384 241.685 728.048C241.151 727.713 240.52 727.545 239.793 727.545C238.992 727.545 238.299 727.744 237.713 728.142C237.134 728.534 236.688 729.045 236.375 729.676C236.063 730.307 235.907 730.983 235.907 731.705V732.864C235.907 733.852 236.077 734.69 236.418 735.378C236.765 736.06 237.245 736.58 237.858 736.938C238.472 737.29 239.185 737.466 239.998 737.466C240.526 737.466 241.003 737.392 241.429 737.244C241.861 737.091 242.233 736.864 242.546 736.562C242.858 736.256 243.1 735.875 243.27 735.42L245.213 735.966C245.009 736.625 244.665 737.205 244.182 737.705C243.699 738.199 243.103 738.585 242.392 738.864C241.682 739.136 240.884 739.273 239.998 739.273ZM250.489 721.545V739H248.478V721.545H250.489ZM259.662 739.273C258.4 739.273 257.312 738.994 256.397 738.438C255.488 737.875 254.787 737.091 254.292 736.085C253.804 735.074 253.559 733.898 253.559 732.557C253.559 731.216 253.804 730.034 254.292 729.011C254.787 727.983 255.474 727.182 256.355 726.608C257.241 726.028 258.275 725.739 259.457 725.739C260.139 725.739 260.812 725.852 261.477 726.08C262.142 726.307 262.747 726.676 263.292 727.188C263.838 727.693 264.272 728.364 264.596 729.199C264.92 730.034 265.082 731.062 265.082 732.284V733.136H254.991V731.398H263.037C263.037 730.659 262.889 730 262.593 729.42C262.304 728.841 261.889 728.384 261.349 728.048C260.815 727.713 260.184 727.545 259.457 727.545C258.656 727.545 257.963 727.744 257.377 728.142C256.798 728.534 256.352 729.045 256.039 729.676C255.727 730.307 255.571 730.983 255.571 731.705V732.864C255.571 733.852 255.741 734.69 256.082 735.378C256.429 736.06 256.909 736.58 257.522 736.938C258.136 737.29 258.849 737.466 259.662 737.466C260.19 737.466 260.667 737.392 261.093 737.244C261.525 737.091 261.897 736.864 262.21 736.562C262.522 736.256 262.764 735.875 262.934 735.42L264.877 735.966C264.673 736.625 264.329 737.205 263.846 737.705C263.363 738.199 262.767 738.585 262.056 738.864C261.346 739.136 260.548 739.273 259.662 739.273ZM271.994 739.307C271.164 739.307 270.412 739.151 269.735 738.838C269.059 738.52 268.522 738.062 268.125 737.466C267.727 736.864 267.528 736.136 267.528 735.284C267.528 734.534 267.676 733.926 267.971 733.46C268.267 732.989 268.662 732.619 269.156 732.352C269.65 732.085 270.196 731.886 270.792 731.756C271.395 731.619 272 731.511 272.608 731.432C273.403 731.33 274.048 731.253 274.542 731.202C275.042 731.145 275.406 731.051 275.633 730.92C275.866 730.79 275.983 730.562 275.983 730.239V730.17C275.983 729.33 275.752 728.676 275.292 728.21C274.838 727.744 274.147 727.511 273.221 727.511C272.261 727.511 271.508 727.722 270.963 728.142C270.417 728.562 270.034 729.011 269.812 729.489L267.903 728.807C268.244 728.011 268.699 727.392 269.267 726.949C269.841 726.5 270.466 726.187 271.142 726.011C271.824 725.83 272.494 725.739 273.153 725.739C273.574 725.739 274.056 725.79 274.602 725.892C275.153 725.989 275.684 726.19 276.196 726.497C276.713 726.804 277.142 727.267 277.483 727.886C277.824 728.506 277.994 729.335 277.994 730.375V739H275.983V737.227H275.88C275.744 737.511 275.517 737.815 275.199 738.139C274.88 738.463 274.457 738.739 273.929 738.966C273.4 739.193 272.755 739.307 271.994 739.307ZM272.301 737.5C273.096 737.5 273.767 737.344 274.312 737.031C274.863 736.719 275.278 736.315 275.556 735.821C275.841 735.327 275.983 734.807 275.983 734.261V732.42C275.897 732.523 275.71 732.616 275.42 732.702C275.136 732.781 274.806 732.852 274.431 732.915C274.062 732.972 273.701 733.023 273.349 733.068C273.002 733.108 272.721 733.142 272.505 733.17C271.983 733.239 271.494 733.349 271.039 733.503C270.591 733.651 270.227 733.875 269.949 734.176C269.676 734.472 269.539 734.875 269.539 735.386C269.539 736.085 269.798 736.614 270.315 736.972C270.838 737.324 271.5 737.5 272.301 737.5ZM290.938 728.841L289.131 729.352C289.017 729.051 288.85 728.759 288.628 728.474C288.412 728.185 288.117 727.946 287.742 727.759C287.367 727.571 286.887 727.477 286.301 727.477C285.5 727.477 284.833 727.662 284.299 728.031C283.77 728.395 283.506 728.858 283.506 729.42C283.506 729.92 283.688 730.315 284.051 730.605C284.415 730.895 284.983 731.136 285.756 731.33L287.699 731.807C288.87 732.091 289.742 732.526 290.316 733.111C290.89 733.69 291.176 734.437 291.176 735.352C291.176 736.102 290.961 736.773 290.529 737.364C290.103 737.955 289.506 738.42 288.739 738.761C287.972 739.102 287.08 739.273 286.063 739.273C284.728 739.273 283.623 738.983 282.748 738.403C281.873 737.824 281.319 736.977 281.086 735.864L282.995 735.386C283.176 736.091 283.52 736.619 284.026 736.972C284.537 737.324 285.205 737.5 286.029 737.5C286.966 737.5 287.711 737.301 288.262 736.903C288.819 736.5 289.097 736.017 289.097 735.455C289.097 735 288.938 734.619 288.62 734.312C288.301 734 287.813 733.767 287.154 733.614L284.972 733.102C283.773 732.818 282.892 732.378 282.33 731.781C281.773 731.179 281.495 730.426 281.495 729.523C281.495 728.784 281.702 728.131 282.117 727.562C282.537 726.994 283.108 726.548 283.83 726.224C284.557 725.901 285.381 725.739 286.301 725.739C287.597 725.739 288.614 726.023 289.353 726.591C290.097 727.159 290.625 727.909 290.938 728.841ZM299.693 739.273C298.431 739.273 297.343 738.994 296.429 738.438C295.52 737.875 294.818 737.091 294.324 736.085C293.835 735.074 293.591 733.898 293.591 732.557C293.591 731.216 293.835 730.034 294.324 729.011C294.818 727.983 295.505 727.182 296.386 726.608C297.272 726.028 298.306 725.739 299.488 725.739C300.17 725.739 300.843 725.852 301.508 726.08C302.173 726.307 302.778 726.676 303.324 727.188C303.869 727.693 304.304 728.364 304.627 729.199C304.951 730.034 305.113 731.062 305.113 732.284V733.136H295.022V731.398H303.068C303.068 730.659 302.92 730 302.625 729.42C302.335 728.841 301.92 728.384 301.38 728.048C300.846 727.713 300.216 727.545 299.488 727.545C298.687 727.545 297.994 727.744 297.409 728.142C296.829 728.534 296.383 729.045 296.071 729.676C295.758 730.307 295.602 730.983 295.602 731.705V732.864C295.602 733.852 295.772 734.69 296.113 735.378C296.46 736.06 296.94 736.58 297.554 736.938C298.167 737.29 298.88 737.466 299.693 737.466C300.221 737.466 300.699 737.392 301.125 737.244C301.556 737.091 301.929 736.864 302.241 736.562C302.554 736.256 302.795 735.875 302.966 735.42L304.909 735.966C304.704 736.625 304.36 737.205 303.877 737.705C303.395 738.199 302.798 738.585 302.088 738.864C301.377 739.136 300.579 739.273 299.693 739.273ZM317.446 728.841L315.639 729.352C315.525 729.051 315.358 728.759 315.136 728.474C314.92 728.185 314.625 727.946 314.25 727.759C313.875 727.571 313.395 727.477 312.809 727.477C312.008 727.477 311.341 727.662 310.806 728.031C310.278 728.395 310.014 728.858 310.014 729.42C310.014 729.92 310.196 730.315 310.559 730.605C310.923 730.895 311.491 731.136 312.264 731.33L314.207 731.807C315.377 732.091 316.25 732.526 316.824 733.111C317.397 733.69 317.684 734.437 317.684 735.352C317.684 736.102 317.468 736.773 317.037 737.364C316.61 737.955 316.014 738.42 315.247 738.761C314.48 739.102 313.588 739.273 312.571 739.273C311.235 739.273 310.13 738.983 309.255 738.403C308.38 737.824 307.826 736.977 307.593 735.864L309.502 735.386C309.684 736.091 310.028 736.619 310.534 736.972C311.045 737.324 311.713 737.5 312.537 737.5C313.474 737.5 314.218 737.301 314.77 736.903C315.326 736.5 315.605 736.017 315.605 735.455C315.605 735 315.446 734.619 315.127 734.312C314.809 734 314.321 733.767 313.662 733.614L311.48 733.102C310.281 732.818 309.4 732.378 308.838 731.781C308.281 731.179 308.002 730.426 308.002 729.523C308.002 728.784 308.21 728.131 308.625 727.562C309.045 726.994 309.616 726.548 310.338 726.224C311.065 725.901 311.889 725.739 312.809 725.739C314.105 725.739 315.122 726.023 315.86 726.591C316.605 727.159 317.133 727.909 317.446 728.841ZM342.462 730.273C342.462 732.114 342.13 733.705 341.465 735.045C340.8 736.386 339.888 737.42 338.729 738.148C337.57 738.875 336.246 739.239 334.757 739.239C333.269 739.239 331.945 738.875 330.786 738.148C329.627 737.42 328.715 736.386 328.05 735.045C327.385 733.705 327.053 732.114 327.053 730.273C327.053 728.432 327.385 726.841 328.05 725.5C328.715 724.159 329.627 723.125 330.786 722.398C331.945 721.67 333.269 721.307 334.757 721.307C336.246 721.307 337.57 721.67 338.729 722.398C339.888 723.125 340.8 724.159 341.465 725.5C342.13 726.841 342.462 728.432 342.462 730.273ZM340.417 730.273C340.417 728.761 340.164 727.486 339.658 726.446C339.158 725.406 338.479 724.619 337.621 724.085C336.769 723.551 335.814 723.284 334.757 723.284C333.701 723.284 332.743 723.551 331.885 724.085C331.033 724.619 330.354 725.406 329.848 726.446C329.348 727.486 329.098 728.761 329.098 730.273C329.098 731.784 329.348 733.06 329.848 734.099C330.354 735.139 331.033 735.926 331.885 736.46C332.743 736.994 333.701 737.261 334.757 737.261C335.814 737.261 336.769 736.994 337.621 736.46C338.479 735.926 339.158 735.139 339.658 734.099C340.164 733.06 340.417 731.784 340.417 730.273ZM351.061 739.273C349.834 739.273 348.777 738.983 347.891 738.403C347.005 737.824 346.323 737.026 345.846 736.009C345.368 734.991 345.13 733.83 345.13 732.523C345.13 731.193 345.374 730.02 345.863 729.003C346.357 727.98 347.044 727.182 347.925 726.608C348.811 726.028 349.846 725.739 351.027 725.739C351.948 725.739 352.777 725.909 353.516 726.25C354.255 726.591 354.86 727.068 355.331 727.682C355.803 728.295 356.096 729.011 356.209 729.83H354.198C354.044 729.233 353.703 728.705 353.175 728.244C352.652 727.778 351.948 727.545 351.061 727.545C350.277 727.545 349.59 727.75 348.999 728.159C348.414 728.562 347.956 729.134 347.627 729.872C347.303 730.605 347.141 731.466 347.141 732.455C347.141 733.466 347.3 734.347 347.618 735.097C347.942 735.847 348.397 736.429 348.982 736.844C349.573 737.259 350.266 737.466 351.061 737.466C351.584 737.466 352.059 737.375 352.485 737.193C352.911 737.011 353.272 736.75 353.567 736.409C353.863 736.068 354.073 735.659 354.198 735.182H356.209C356.096 735.955 355.814 736.651 355.365 737.27C354.922 737.884 354.334 738.372 353.601 738.736C352.874 739.094 352.027 739.273 351.061 739.273ZM364.843 725.909V727.614H358.059V725.909H364.843ZM360.036 722.773H362.047V735.25C362.047 735.818 362.13 736.244 362.294 736.528C362.465 736.807 362.681 736.994 362.942 737.091C363.209 737.182 363.49 737.227 363.786 737.227C364.007 737.227 364.189 737.216 364.331 737.193C364.473 737.165 364.587 737.142 364.672 737.125L365.081 738.932C364.945 738.983 364.755 739.034 364.51 739.085C364.266 739.142 363.956 739.17 363.581 739.17C363.013 739.17 362.456 739.048 361.911 738.804C361.371 738.56 360.922 738.188 360.564 737.688C360.212 737.188 360.036 736.557 360.036 735.795V722.773ZM373.046 739.273C371.864 739.273 370.827 738.991 369.935 738.429C369.049 737.866 368.355 737.08 367.855 736.068C367.361 735.057 367.114 733.875 367.114 732.523C367.114 731.159 367.361 729.969 367.855 728.952C368.355 727.935 369.049 727.145 369.935 726.582C370.827 726.02 371.864 725.739 373.046 725.739C374.228 725.739 375.262 726.02 376.148 726.582C377.04 727.145 377.733 727.935 378.228 728.952C378.728 729.969 378.978 731.159 378.978 732.523C378.978 733.875 378.728 735.057 378.228 736.068C377.733 737.08 377.04 737.866 376.148 738.429C375.262 738.991 374.228 739.273 373.046 739.273ZM373.046 737.466C373.944 737.466 374.682 737.236 375.262 736.776C375.841 736.315 376.27 735.71 376.549 734.96C376.827 734.21 376.966 733.398 376.966 732.523C376.966 731.648 376.827 730.832 376.549 730.077C376.27 729.321 375.841 728.71 375.262 728.244C374.682 727.778 373.944 727.545 373.046 727.545C372.148 727.545 371.409 727.778 370.83 728.244C370.25 728.71 369.821 729.321 369.543 730.077C369.265 730.832 369.125 731.648 369.125 732.523C369.125 733.398 369.265 734.21 369.543 734.96C369.821 735.71 370.25 736.315 370.83 736.776C371.409 737.236 372.148 737.466 373.046 737.466ZM382.321 739V721.545H384.332V727.989H384.502C384.65 727.761 384.855 727.472 385.116 727.119C385.383 726.761 385.764 726.443 386.258 726.165C386.758 725.881 387.434 725.739 388.287 725.739C389.389 725.739 390.36 726.014 391.201 726.565C392.042 727.116 392.699 727.898 393.17 728.909C393.642 729.92 393.877 731.114 393.877 732.489C393.877 733.875 393.642 735.077 393.17 736.094C392.699 737.105 392.045 737.889 391.21 738.446C390.375 738.997 389.412 739.273 388.321 739.273C387.48 739.273 386.806 739.134 386.301 738.855C385.795 738.571 385.406 738.25 385.133 737.892C384.86 737.528 384.65 737.227 384.502 736.989H384.264V739H382.321ZM384.298 732.455C384.298 733.443 384.443 734.315 384.733 735.071C385.022 735.821 385.446 736.409 386.002 736.835C386.559 737.256 387.241 737.466 388.048 737.466C388.889 737.466 389.591 737.244 390.153 736.801C390.721 736.352 391.147 735.75 391.431 734.994C391.721 734.233 391.866 733.386 391.866 732.455C391.866 731.534 391.724 730.705 391.44 729.966C391.162 729.222 390.738 728.634 390.17 728.202C389.608 727.764 388.9 727.545 388.048 727.545C387.23 727.545 386.542 727.753 385.985 728.168C385.429 728.577 385.008 729.151 384.724 729.889C384.44 730.622 384.298 731.477 384.298 732.455ZM402.443 739.273C401.181 739.273 400.093 738.994 399.179 738.438C398.27 737.875 397.568 737.091 397.074 736.085C396.585 735.074 396.341 733.898 396.341 732.557C396.341 731.216 396.585 730.034 397.074 729.011C397.568 727.983 398.255 727.182 399.136 726.608C400.022 726.028 401.056 725.739 402.238 725.739C402.92 725.739 403.593 725.852 404.258 726.08C404.923 726.307 405.528 726.676 406.074 727.188C406.619 727.693 407.054 728.364 407.377 729.199C407.701 730.034 407.863 731.062 407.863 732.284V733.136H397.772V731.398H405.818C405.818 730.659 405.67 730 405.375 729.42C405.085 728.841 404.67 728.384 404.13 728.048C403.596 727.713 402.966 727.545 402.238 727.545C401.437 727.545 400.744 727.744 400.159 728.142C399.579 728.534 399.133 729.045 398.821 729.676C398.508 730.307 398.352 730.983 398.352 731.705V732.864C398.352 733.852 398.522 734.69 398.863 735.378C399.21 736.06 399.69 736.58 400.304 736.938C400.917 737.29 401.63 737.466 402.443 737.466C402.971 737.466 403.449 737.392 403.875 737.244C404.306 737.091 404.679 736.864 404.991 736.562C405.304 736.256 405.545 735.875 405.716 735.42L407.659 735.966C407.454 736.625 407.11 737.205 406.627 737.705C406.145 738.199 405.548 738.585 404.838 738.864C404.127 739.136 403.329 739.273 402.443 739.273ZM410.923 739V725.909H412.866V727.886H413.002C413.241 727.239 413.673 726.713 414.298 726.31C414.923 725.906 415.627 725.705 416.412 725.705C416.559 725.705 416.744 725.707 416.966 725.713C417.187 725.719 417.355 725.727 417.468 725.739V727.784C417.4 727.767 417.244 727.741 417 727.707C416.761 727.668 416.508 727.648 416.241 727.648C415.605 727.648 415.037 727.781 414.537 728.048C414.042 728.31 413.65 728.673 413.36 729.139C413.076 729.599 412.934 730.125 412.934 730.716V739H410.923ZM432.023 739.239C431.023 739.239 430.123 739.04 429.321 738.642C428.52 738.244 427.878 737.699 427.395 737.006C426.912 736.312 426.648 735.523 426.603 734.636H428.648C428.728 735.426 429.086 736.08 429.722 736.597C430.364 737.108 431.131 737.364 432.023 737.364C432.739 737.364 433.375 737.196 433.932 736.861C434.495 736.526 434.935 736.065 435.253 735.48C435.577 734.889 435.739 734.222 435.739 733.477C435.739 732.716 435.571 732.037 435.236 731.44C434.907 730.838 434.452 730.364 433.873 730.017C433.293 729.67 432.631 729.494 431.887 729.489C431.353 729.483 430.804 729.565 430.242 729.736C429.679 729.901 429.216 730.114 428.853 730.375L426.875 730.136L427.932 721.545H437V723.42H429.705L429.091 728.568H429.194C429.551 728.284 430 728.048 430.54 727.861C431.08 727.673 431.642 727.58 432.228 727.58C433.296 727.58 434.248 727.835 435.083 728.347C435.924 728.852 436.583 729.545 437.06 730.426C437.543 731.307 437.784 732.312 437.784 733.443C437.784 734.557 437.534 735.551 437.034 736.426C436.54 737.295 435.858 737.983 434.989 738.489C434.12 738.989 433.131 739.239 432.023 739.239ZM446.897 725.909V727.614H440.113V725.909H446.897ZM442.091 722.773H444.102V735.25C444.102 735.818 444.184 736.244 444.349 736.528C444.52 736.807 444.735 736.994 444.997 737.091C445.264 737.182 445.545 737.227 445.841 737.227C446.062 737.227 446.244 737.216 446.386 737.193C446.528 737.165 446.642 737.142 446.727 737.125L447.136 738.932C447 738.983 446.809 739.034 446.565 739.085C446.321 739.142 446.011 739.17 445.636 739.17C445.068 739.17 444.511 739.048 443.966 738.804C443.426 738.56 442.977 738.188 442.619 737.688C442.267 737.188 442.091 736.557 442.091 735.795V722.773ZM452.216 731.125V739H450.204V721.545H452.216V727.955H452.386C452.693 727.278 453.153 726.741 453.767 726.344C454.386 725.94 455.21 725.739 456.238 725.739C457.13 725.739 457.912 725.918 458.582 726.276C459.252 726.628 459.772 727.17 460.142 727.903C460.517 728.631 460.704 729.557 460.704 730.682V739H458.693V730.818C458.693 729.778 458.423 728.974 457.883 728.406C457.349 727.832 456.608 727.545 455.659 727.545C455 727.545 454.409 727.685 453.886 727.963C453.369 728.241 452.96 728.648 452.659 729.182C452.363 729.716 452.216 730.364 452.216 731.125Z" fill="white"/>
                </g>
                <defs>
                <clipPath id="clip0_2375_586">
                <rect width="680" height="880" rx="12" fill="white"/>
                </clipPath>
                </defs>
            </svg>

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
  <div id="login-button-container" class="login-button-container" data-federated-csrf="${federatedCSRFToken}">
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
[#macro input type name id autocapitalize="none" autocomplete="on" autocorrect="off" autofocus=false spellcheck="false" label="" placeholder="" leftAddon="" required=false tooltip="" disabled=false class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded max-md:max-w-full p-2 outline-primary" dateTimeFormat="" value="" uncheckedValue=""]
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
<button class="${color} btn btn-primary button${disabled?then(' disabled', '')}"[#if disabled] disabled="disabled"[/#if][#if name !=""]name="${name}"[/#if][#if value !=""]value="${value}"[/#if]>${text}</button>
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

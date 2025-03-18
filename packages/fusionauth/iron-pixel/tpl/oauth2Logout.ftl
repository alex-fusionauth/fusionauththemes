[#ftl/]
[#-- @ftlvariable name="allLogoutURLs" type="java.util.Set<java.lang.String>" --]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="currentUser" type="io.fusionauth.domain.User" --]
[#-- @ftlvariable name="registeredLogoutURLs" type="java.util.Set<java.lang.String>" --]
[#-- @ftlvariable name="redirectURL" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]

[#-- You may adjust the duration before we redirect the user --]
[#assign logoutDurationInSeconds = 2 /]

[@helpers.html]
  [@helpers.head title=theme.message("logout-title")]
  [#if redirectURL?has_content]
    <meta http-equiv="Refresh" content="${logoutDurationInSeconds}; url=${redirectURL}">
  [/#if]
  [/@helpers.head]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]
    <div class="h-screen w-screen flex flex-col gap-8 justify-center items-center">
      <div>${theme.message("logging-out")}</div>
      <div><progress id="logoutProgress" class="progress w-56" value="0" max="100"></progress></div>
    </div>

      <script>
        const progressBar = document.getElementById('logoutProgress');
        const duration = ${logoutDurationInSeconds}; // Get duration from FTL variable
        let progress = 0;
        
        const interval = setInterval(() => {
          progress += (100 / (duration * 10)); // Increase by 10% per second
          if (progress >= 100) {
            progress = 100;
            clearInterval(interval);
          }
          progressBar.value = progress;
        }, 100); // Update every 100ms for smooth animation
      </script>

    [#-- Use allLogoutURLs to call the logout URL of all applications in the tenant, or use registeredLogoutURLs to log out of just the applications the user is currently registered.
        Note, that just because a user does not currently have a registration, does not necessarily mean the user does not hold a session with an application. It is possible the user has been un-registered
        recently, or an application may have created a session for a user regardless of their registration. In most cases it is safest to simply call all applications and ensure that the Single Logout
        URL can handle logout requests for users that may or may not have a session with that application.
     --]
    [#list allLogoutURLs![] as logoutURL]
      <iframe src="${logoutURL}" style="width:0; height:0; border:0; border:none;"></iframe>
    [/#list]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]

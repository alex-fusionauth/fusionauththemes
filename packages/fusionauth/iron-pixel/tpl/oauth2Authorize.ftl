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

    [@helpers.main title=theme.message("login")]

      <section class="grid grid-cols-1 lg:grid-cols-2 m-8">
        [#-- Photo --]
        <div class="hidden lg:flex overflow-hidden relative flex-col justify-center px-8 py-44 max-md:px-5 max-md:max-w-full">
          <img
            loading="lazy"
            src="https://res.cloudinary.com/djox1exln/image/upload/v1739206563/background-left_hbtcsz.jpg"
            class="object-cover absolute inset-0 size-full"
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
        <div class="flex overflow-hidden relative flex-col justify-center px-28 py-8 max-md:px-5 max-md:max-w-full">

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
          <div
            class="object-contain self-center max-w-full aspect-[8.47] w-[273px] absolute top-0 mt-8"
            alt="Logo"
          >
            <svg width="274" height="33" viewBox="0 0 274 33" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M5.76287 6.80489L21.0739 13.6098V32.3232L0.999451 22.1159L5.76287 6.80489Z" fill="url(#paint0_radial_2243_944)"/>
            <path d="M36.3849 6.80489L21.0739 13.6098V32.3232L41.1483 22.1159L36.3849 6.80489Z" fill="url(#paint1_radial_2243_944)"/>
            <path fill-rule="evenodd" clip-rule="evenodd" d="M21.0739 2.97868L33.6629 8.57381V14.9707H8.48483V8.57381L21.0739 2.97868ZM5.76287 6.80489L21.0739 0L36.3849 6.80489V17.6927H5.76287V6.80489Z" fill="url(#paint2_radial_2243_944)"/>
            <path d="M273.277 9.92484H269.821V9.14552C269.821 8.3549 269.629 7.67723 269.245 7.1125C268.883 6.52518 268.262 6.23152 267.381 6.23152C266.907 6.23152 266.523 6.32188 266.229 6.50259C265.935 6.6833 265.698 6.9092 265.517 7.18027C265.337 7.47392 265.212 7.81276 265.145 8.19677C265.077 8.5582 265.043 8.94221 265.043 9.34882C265.043 9.82319 265.054 10.2185 265.077 10.5347C265.122 10.851 265.212 11.1334 265.348 11.3818C265.483 11.6303 265.675 11.8449 265.924 12.0256C266.195 12.2063 266.556 12.3871 267.008 12.5678L269.651 13.6182C270.419 13.9118 271.04 14.2619 271.515 14.6685C271.989 15.0526 272.362 15.5043 272.633 16.0239C272.881 16.566 273.051 17.1872 273.141 17.8875C273.232 18.5652 273.277 19.3445 273.277 20.2255C273.277 21.242 273.175 22.1907 272.972 23.0717C272.768 23.9301 272.441 24.6642 271.989 25.2741C271.515 25.9066 270.894 26.4036 270.126 26.765C269.357 27.1264 268.42 27.3071 267.313 27.3071C266.477 27.3071 265.698 27.1603 264.975 26.8667C264.252 26.573 263.631 26.1664 263.112 25.6468C262.592 25.1273 262.174 24.5287 261.858 23.851C261.564 23.1508 261.417 22.394 261.417 21.5808V20.2932H264.874V21.3775C264.874 22.01 265.054 22.586 265.416 23.1056C265.8 23.6025 266.432 23.851 267.313 23.851C267.9 23.851 268.352 23.772 268.669 23.6138C269.007 23.4331 269.267 23.1846 269.448 22.8684C269.629 22.5521 269.73 22.1794 269.753 21.7502C269.798 21.2984 269.821 20.8015 269.821 20.2593C269.821 19.6269 269.798 19.1073 269.753 18.7007C269.708 18.2941 269.617 17.9666 269.482 17.7181C269.324 17.4696 269.109 17.2663 268.838 17.1082C268.589 16.95 268.251 16.7806 267.821 16.5999L265.348 15.5834C263.857 14.9735 262.852 14.1716 262.332 13.1777C261.835 12.1612 261.587 10.8962 261.587 9.3827C261.587 8.47914 261.711 7.62075 261.96 6.80754C262.208 5.99434 262.581 5.29408 263.078 4.70676C263.552 4.11944 264.151 3.65637 264.874 3.31753C265.619 2.9561 266.5 2.77539 267.516 2.77539C268.375 2.77539 269.154 2.93351 269.854 3.24976C270.577 3.56601 271.198 3.98391 271.718 4.50346C272.757 5.58773 273.277 6.83013 273.277 8.23066V9.92484Z" fill="white"/>
            <path d="M246.449 8.67114C246.449 7.69981 246.618 6.84143 246.957 6.09599C247.296 5.35055 247.748 4.72935 248.312 4.23239C248.854 3.75802 249.464 3.39659 250.142 3.14811C250.842 2.89963 251.543 2.77539 252.243 2.77539C252.943 2.77539 253.632 2.89963 254.31 3.14811C255.01 3.39659 255.642 3.75802 256.207 4.23239C256.749 4.72935 257.19 5.35055 257.529 6.09599C257.867 6.84143 258.037 7.69981 258.037 8.67114V21.4114C258.037 22.4279 257.867 23.2976 257.529 24.0204C257.19 24.7433 256.749 25.3419 256.207 25.8163C255.642 26.3132 255.01 26.6859 254.31 26.9344C253.632 27.1829 252.943 27.3071 252.243 27.3071C251.543 27.3071 250.842 27.1829 250.142 26.9344C249.464 26.6859 248.854 26.3132 248.312 25.8163C247.748 25.3419 247.296 24.7433 246.957 24.0204C246.618 23.2976 246.449 22.4279 246.449 21.4114V8.67114ZM249.905 21.4114C249.905 22.2472 250.131 22.8684 250.582 23.275C251.057 23.659 251.61 23.851 252.243 23.851C252.875 23.851 253.417 23.659 253.869 23.275C254.344 22.8684 254.581 22.2472 254.581 21.4114V8.67114C254.581 7.83535 254.344 7.22544 253.869 6.84143C253.417 6.43482 252.875 6.23152 252.243 6.23152C251.61 6.23152 251.057 6.43482 250.582 6.84143C250.131 7.22544 249.905 7.83535 249.905 8.67114V21.4114Z" fill="white"/>
            <path d="M238.824 27.1039V2.97876H242.28V27.1039H238.824Z" fill="white"/>
            <path d="M223.277 27.1039V2.97876H228.393C230.381 2.97876 231.883 3.5209 232.9 4.60517C233.939 5.68945 234.458 7.22551 234.458 9.21335V20.4966C234.458 22.7555 233.905 24.4271 232.798 25.5114C231.714 26.5731 230.144 27.1039 228.088 27.1039H223.277ZM226.733 6.23159V23.8511H228.325C229.297 23.8511 229.986 23.6139 230.392 23.1395C230.799 22.6426 231.002 21.8745 231.002 20.8354V9.21335C231.002 8.26461 230.81 7.53046 230.426 7.01091C230.042 6.49136 229.342 6.23159 228.325 6.23159H226.733Z" fill="white"/>
            <path d="M219.013 2.97876V21.6825C219.013 22.4731 218.866 23.2073 218.573 23.885C218.302 24.54 217.906 25.1274 217.387 25.6469C216.867 26.1665 216.269 26.5731 215.591 26.8667C214.913 27.1604 214.19 27.3072 213.422 27.3072C212.654 27.3072 211.931 27.1604 211.254 26.8667C210.599 26.5731 210.011 26.1665 209.492 25.6469C208.972 25.1274 208.566 24.54 208.272 23.885C207.978 23.2073 207.831 22.4731 207.831 21.6825V2.97876H211.288V21.3437C211.288 22.2021 211.491 22.8346 211.898 23.2412C212.304 23.6478 212.812 23.8511 213.422 23.8511C214.032 23.8511 214.54 23.6478 214.947 23.2412C215.354 22.8346 215.557 22.2021 215.557 21.3437V2.97876H219.013Z" fill="white"/>
            <path d="M197.834 27.1039V6.23159H193.835V2.97876H205.288V6.23159H201.29V27.1039H197.834Z" fill="white"/>
            <path d="M191.964 9.92484H188.508V9.14552C188.508 8.3549 188.316 7.67723 187.932 7.1125C187.571 6.52518 186.949 6.23152 186.068 6.23152C185.594 6.23152 185.21 6.32188 184.916 6.50259C184.623 6.6833 184.386 6.9092 184.205 7.18027C184.024 7.47392 183.9 7.81276 183.832 8.19677C183.764 8.5582 183.73 8.94221 183.73 9.34882C183.73 9.82319 183.742 10.2185 183.764 10.5347C183.81 10.851 183.9 11.1334 184.035 11.3818C184.171 11.6303 184.363 11.8449 184.611 12.0256C184.883 12.2063 185.244 12.3871 185.696 12.5678L188.339 13.6182C189.107 13.9118 189.728 14.2619 190.202 14.6685C190.677 15.0526 191.049 15.5043 191.32 16.0239C191.569 16.566 191.738 17.1872 191.829 17.8875C191.919 18.5652 191.964 19.3445 191.964 20.2255C191.964 21.242 191.863 22.1907 191.659 23.0717C191.456 23.9301 191.128 24.6642 190.677 25.2741C190.202 25.9066 189.581 26.4036 188.813 26.765C188.045 27.1264 187.108 27.3071 186.001 27.3071C185.165 27.3071 184.386 27.1603 183.663 26.8667C182.94 26.573 182.319 26.1664 181.799 25.6468C181.28 25.1273 180.862 24.5287 180.545 23.851C180.252 23.1508 180.105 22.394 180.105 21.5808V20.2932H183.561V21.3775C183.561 22.01 183.742 22.586 184.103 23.1056C184.487 23.6025 185.12 23.851 186.001 23.851C186.588 23.851 187.04 23.772 187.356 23.6138C187.695 23.4331 187.955 23.1846 188.135 22.8684C188.316 22.5521 188.418 22.1794 188.44 21.7502C188.485 21.2984 188.508 20.8015 188.508 20.2593C188.508 19.6269 188.485 19.1073 188.44 18.7007C188.395 18.2941 188.305 17.9666 188.169 17.7181C188.011 17.4696 187.797 17.2663 187.525 17.1082C187.277 16.95 186.938 16.7806 186.509 16.5999L184.035 15.5834C182.545 14.9735 181.539 14.1716 181.02 13.1777C180.523 12.1612 180.274 10.8962 180.274 9.3827C180.274 8.47914 180.399 7.62075 180.647 6.80754C180.896 5.99434 181.268 5.29408 181.765 4.70676C182.24 4.11944 182.838 3.65637 183.561 3.31753C184.306 2.9561 185.187 2.77539 186.204 2.77539C187.062 2.77539 187.842 2.93351 188.542 3.24976C189.265 3.56601 189.886 3.98391 190.406 4.50346C191.445 5.58773 191.964 6.83013 191.964 8.23066V9.92484Z" fill="white"/>
            <path d="M159.925 27.1039V2.97876H163.381V23.6478H170.226V27.1039H159.925Z" fill="white"/>
            <path d="M146.363 27.1039V2.97876H156.663V6.23159H149.819V13.3133H155.782V16.5661H149.819V23.6478H156.663V27.1039H146.363Z" fill="white"/>
            <path d="M130.488 27.1039L135.367 14.4653L130.86 2.97876H134.52L137.129 10.1282L139.772 2.97876H143.431L138.823 14.4653L143.804 27.1039H140.145L137.129 18.9718L134.147 27.1039H130.488Z" fill="white"/>
            <path d="M124.347 27.1039V2.97876H127.803V27.1039H124.347Z" fill="white"/>
            <path d="M109.433 27.1039V2.97876H114.617C115.566 2.97876 116.402 3.103 117.125 3.35148C117.847 3.59996 118.503 4.04045 119.09 4.67294C119.677 5.30544 120.084 6.05088 120.31 6.90926C120.536 7.74506 120.649 8.88581 120.649 10.3315C120.649 11.4158 120.581 12.3306 120.445 13.0761C120.332 13.8215 120.073 14.5218 119.666 15.1769C119.192 15.9675 118.559 16.5887 117.768 17.0405C116.978 17.4697 115.939 17.6843 114.651 17.6843H112.889V27.1039H109.433ZM112.889 6.23159V14.4314H114.549C115.25 14.4314 115.792 14.3298 116.176 14.1265C116.56 13.9232 116.842 13.6408 117.023 13.2794C117.204 12.9405 117.305 12.5227 117.328 12.0257C117.373 11.5287 117.396 10.9753 117.396 10.3654C117.396 9.80066 117.384 9.26982 117.362 8.77286C117.339 8.25331 117.238 7.80153 117.057 7.41752C116.876 7.0335 116.605 6.73984 116.244 6.53654C115.882 6.33324 115.363 6.23159 114.685 6.23159H112.889Z" fill="white"/>
            <path d="M85.9213 27.1039V2.97876H89.2419L94.46 17.5148H94.5278V2.97876H97.9839V27.1039H94.7311L89.4452 12.6017H89.3775V27.1039H85.9213Z" fill="white"/>
            <path d="M70.4096 8.67114C70.4096 7.69981 70.579 6.84143 70.9179 6.09599C71.2567 5.35055 71.7085 4.72935 72.2732 4.23239C72.8153 3.75802 73.4253 3.39659 74.1029 3.14811C74.8032 2.89963 75.5034 2.77539 76.2037 2.77539C76.904 2.77539 77.5929 2.89963 78.2706 3.14811C78.9709 3.39659 79.6034 3.75802 80.1681 4.23239C80.7102 4.72935 81.1507 5.35055 81.4896 6.09599C81.8284 6.84143 81.9978 7.69981 81.9978 8.67114V21.4114C81.9978 22.4279 81.8284 23.2976 81.4896 24.0204C81.1507 24.7433 80.7102 25.3419 80.1681 25.8163C79.6034 26.3132 78.9709 26.6859 78.2706 26.9344C77.5929 27.1829 76.904 27.3071 76.2037 27.3071C75.5034 27.3071 74.8032 27.1829 74.1029 26.9344C73.4253 26.6859 72.8153 26.3132 72.2732 25.8163C71.7085 25.3419 71.2567 24.7433 70.9179 24.0204C70.579 23.2976 70.4096 22.4279 70.4096 21.4114V8.67114ZM73.8657 21.4114C73.8657 22.2472 74.0916 22.8684 74.5434 23.275C75.0178 23.659 75.5712 23.851 76.2037 23.851C76.8362 23.851 77.3783 23.659 77.8301 23.275C78.3045 22.8684 78.5417 22.2472 78.5417 21.4114V8.67114C78.5417 7.83535 78.3045 7.22544 77.8301 6.84143C77.3783 6.43482 76.8362 6.23152 76.2037 6.23152C75.5712 6.23152 75.0178 6.43482 74.5434 6.84143C74.0916 7.22544 73.8657 7.83535 73.8657 8.67114V21.4114Z" fill="white"/>
            <path d="M58.6275 6.23159V13.7538H60.5927C61.2026 13.7538 61.6883 13.6747 62.0497 13.5166C62.4111 13.3359 62.6935 13.0874 62.8968 12.7711C63.0775 12.4549 63.2017 12.0709 63.2695 11.6191C63.3373 11.1447 63.3712 10.6026 63.3712 9.99267C63.3712 9.38277 63.3373 8.85192 63.2695 8.40014C63.2017 7.92577 63.0662 7.51917 62.8629 7.18033C62.4337 6.54784 61.6205 6.23159 60.4233 6.23159H58.6275ZM55.1713 27.1039V2.97876H60.7282C64.7943 2.97876 66.8273 5.33932 66.8273 10.0604C66.8273 11.4836 66.6014 12.6921 66.1496 13.686C65.7204 14.6799 64.9524 15.4818 63.8455 16.0917L67.5727 27.1039H63.9133L60.6944 16.8033H58.6275V27.1039H55.1713Z" fill="white"/>
            <path d="M47.3393 27.1039V2.97876H50.7954V27.1039H47.3393Z" fill="white"/>
            <defs>
            <radialGradient id="paint0_radial_2243_944" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
            <stop stop-color="#1AB7FF"/>
            <stop offset="0.246584" stop-color="#0DC7E3"/>
            <stop offset="0.444146" stop-color="#08C4B6"/>
            <stop offset="0.662916" stop-color="#00C288"/>
            <stop offset="1" stop-color="#00C750"/>
            </radialGradient>
            <radialGradient id="paint1_radial_2243_944" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
            <stop stop-color="#1AB7FF"/>
            <stop offset="0.246584" stop-color="#0DC7E3"/>
            <stop offset="0.444146" stop-color="#08C4B6"/>
            <stop offset="0.662916" stop-color="#00C288"/>
            <stop offset="1" stop-color="#00C750"/>
            </radialGradient>
            <radialGradient id="paint2_radial_2243_944" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(38.2846 6.13697) rotate(156.176) scale(42.0862 42.0862)">
            <stop stop-color="#1AB7FF"/>
            <stop offset="0.246584" stop-color="#0DC7E3"/>
            <stop offset="0.444146" stop-color="#08C4B6"/>
            <stop offset="0.662916" stop-color="#00C288"/>
            <stop offset="1" stop-color="#00C750"/>
            </radialGradient>
            </defs>
            </svg>

          </div>


          
          <div class="relative flex-1 mt-14 w-full max-md:mt-10 max-md:max-w-full">
            <div class="flex items-start w-full text-xl tracking-wide leading-snug border-b border-white border-opacity-30 max-md:max-w-full">
              <div class="flex-1 shrink px-4 pb-4 font-semibold text-white border-b-4 border-teal-500 min-h-11">
                Log In
              </div>
              <div class="flex-1 shrink px-4 pb-4 min-h-11 text-white text-opacity-60">
                Sign Up
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
                  <fieldset>
                    [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message("loginId") leftAddon="user" disabled=(showPasswordField && hasDomainBasedIdentityProviders) class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full" /]
                    [#if showPasswordField]
                      [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message("password") leftAddon="lock" class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full" /]
                      [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
                    [/#if]
                  </fieldset>
                </div>
                [#--                
                  <input
                    type="email"
                    placeholder="Email Address"
                    class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full"
                  />
                </div>
                <div class="flex flex-col justify-center mt-4 w-full whitespace-nowrap rounded bg-cyan-950 max-md:max-w-full">
                  <input
                    type="password"
                    placeholder="Password"
                    class="flex-1 shrink gap-2 self-stretch px-3.5 py-3 w-full rounded bg-cyan-950 max-md:max-w-full"
                  />
                
                --]
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
            [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
          [#else]
            [@helpers.button icon="arrow-right" text=theme.message("next")/]
          [/#if]
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



          <div class="flex flex-col mt-6 w-full text-white max-md:max-w-full">
              <div class="self-start text-base tracking-wide text-center max-md:max-w-full text-center w-full">
                <p>Or, log in with a game account</p>
              </div>
              <div class="grid grid-cols-2 gap-2 mt-6 w-full text-sm font-semibold leading-none max-md:px-5 max-md:max-w-full">
                <button class="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                <img
                  loading="lazy"
                  src="https://cdn.builder.io/api/v1/image/assets/TEMP/8e0e2e25c2d789b1d208ba125c2e30ace387721db9f3cf139caaa4927d080c03?placeholderIfAbsent=true"
                  class="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                  alt="Steam"
                />
                  <span>Steam</span>
                </button>
                <button class="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/560644be9c6a1529f87fa0f087880de2c080a55aa9f3a284f99b9bdf3f36a825?placeholderIfAbsent=true"
                    class="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Xbox"
                  />
                  <span>Xbox</span>
                </button>
                <button class="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto text-center whitespace-nowrap rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/edd6ca3a42adf5079b4780496246dfc4364138569baf436ac3d24330d1491b27?placeholderIfAbsent=true"
                    class="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Twitch"
                  />
                  <span>Twitch</span>
                </button>
                <button class="flex flex-1 shrink gap-2 items-center self-stretch p-2 my-auto rounded basis-0 bg-cyan-950 hover:bg-opacity-80">
                  <img
                    loading="lazy"
                    src="https://cdn.builder.io/api/v1/image/assets/TEMP/825488faa339f626c58e1abe3f7645e34980e8ac1de4ba9c421132efd819a175?placeholderIfAbsent=true"
                    class="object-contain shrink-0 self-stretch my-auto w-8 rounded-sm aspect-square"
                    alt="Epic Games"
                  />
                  <span>Epic Games</span>
                </button>
              </div>
            </div>

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
          </div>
        </div>
      </section>
      [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]

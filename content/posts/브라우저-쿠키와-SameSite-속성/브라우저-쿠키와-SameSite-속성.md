---
title: "브라우저 쿠키와 SameSite 속성"
tags:
  - 브라우저
  - 쿠키
description: '브라우저 쿠키에 대한 기본적인 내용들, 그리고 웹 개발자들에게 중요한 "SameSite" 속성을 다룹니다. "SameSite" 속성이 어떤 속성인지, 각 브라우저에서 어떻게 동작하고 있는지 알아봅니다.'
createdAt: 2021-05-06 01:04:00+09:00
updatedAt: 2021-05-06 01:04:00+09:00
---

쿠키(Cookie)는 대부분의 웹 서비스에서 사용하는 기술이라 웹 개발자라면 여러 번 마주해보셨을 거에요. 저 또한 웹 서비스를 개발하면서 쿠키를 다뤘던 경험이 종종 있었습니다. 그렇지만 쿠키라는 기술 자체는 별로 흥미로운 기술이 아니다보니 그냥 구현만 마친 후 대충 넘겼던 경험이 많은 것 같아요.

쿠키는 아주 예전부터 쓰였던 기술이지만, 요즘에는 보안이나 개인정보보호 문제 때문에 쿠키에 `SameSite` 같은 속성이 추가되기도하고 브라우저가 쿠키를 다루는 방식도 점차 바뀌어가고 있습니다.

이번 글에서는 쿠키에 대한 기본적인 이해를 바탕으로 `SameSite` 속성은 왜 나온 것인지, 브라우저들은 어떻게 동작하고 있는지 알아보겠습니다.

## 쿠키란 무엇인가요? 왜 사용하나요?

쿠키는 브라우저에 데이터를 저장하기 위한 수단 중 하나입니다. 브라우저에서 서버로 요청을 전송할 때 그 요청에 대한 응답에 [Set-Cookie](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Set-Cookie) 헤더가 포함되어있는 경우, 브라우저는 `Set-Cookie` 에 있는 데이터를 저장하고, 이 저장된 데이터를 쿠키라고 부릅니다.

![서버에서 전송하는 응답에 포함된 "Set-Cookie" 헤더](./set-cookie-header.png)

위처럼 서버의 응답에 `Set-Cookie` 헤더가 포함된 경우, `normal` 이라는 이름의 쿠키에 `yes`라는 값이 저장됩니다.

그리고 이렇게 저장된 쿠키는 다음에 다시 그 브라우저에서 서버로 요청을 보낼때, [Cookie](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Cookie)라는 헤더에 같이 전송됩니다. 서버에서는 이 헤더를 읽어서 유저를 식별하는 등 필요한 구현을 할 수 있죠.

![브라우저에서 보내는 요청에 포함된 "Cookie" 헤더](./cookie-header.png)

쿠키는 이렇게 동작하기 때문에 주로 서버에서 사용자를 식별하기 위한 수단으로 사용되어 왔습니다. 애초에 쿠키가 만들어진 목적 자체가 이런 일을 하는 것이기도 하고요. `Set-Cookie` 헤더로 **세션 ID**를 넣어둔 뒤에, 이 후 요청부터 전송될 `Cookie` 헤더의 **세션 ID**를 읽어 어떤 사용자가 보낸 요청인지 판단하는 식으로요. 수 많은 웹 사이트의 로그인 구현이 제가 말씀드린 것과 거의 같은 방식으로 구성되어 있습니다.

## 쿠키에 대한 `Domain` 설정

쿠키가 유효한 사이트를 명시하기 위해 쿠키에 도메인을 설정할 수 있습니다.

!["Domain"이 명시된 "Set-Cookie" 헤더](./set-cookie-with-domain.png)

이렇게 도메인이 설정된 쿠키는 해당 도메인에서만 유효한 쿠키가 됩니다. 위에서 `normal` 쿠키는 `localhost`를 대상으로 쿠키가 설정되었기 때문에, `localhost`를 대상으로 한 요청에만 `normal` 쿠키가 전송됩니다.

쿠키에 별도로 명시된 도메인이 없다면 기본값으로 쿠키를 보낸 서버의 도메인으로 설정됩니다.

## 퍼스트 파티 쿠키와 서드 파티 쿠키

그리고 이렇게 설정된 도메인을 기준으로 퍼스트 파티 쿠키(First-party cookies)와 서드 파티 쿠키(Third-party cookies)가 나뉘어 집니다.

이 부분은 예제를 들어서 설명하는게 좋을 것 같네요.

여러분은 `seob.dev`에 접속한 상태입니다. 만약 `seob.dev`에서 `example.com`이 제공하는 이미지인 `example.com/image.png`를 사용하고 있다고 가정해볼까요? 이 경우 사용자는 `seob.dev`에 접속해 있지만 브라우저에서는 `example.com/image.png`로 요청을 보낼 것 입니다. 아래와 같은 HTML 코드로 나타낼 수 있을 것 같네요.

```html
<html>
  <head>
    <title>seob.dev</title>
    <meta property="og:url" content="https://seob.dev/" />
  </head>
  <body>
    <img src="https://example.com/image.png" />
  </body>
</html>
```

이 때 사용자가 `example.com`에 대한 쿠키를 가지고 있다면, 해당 쿠키가 `example.com`을 운영하는 서버로 같이 전송됩니다. 이 때 전송되는 쿠키를 **서드 파티 쿠키**라고 부릅니다. 그러니까, 서드 파티 쿠키는 **사용자가 접속한 페이지와 다른 도메인으로 전송하는 쿠키**를 말합니다. [Referer](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Referer) 헤더와 쿠키에 설정된 도메인이 다른 쿠키라고도 말할 수 있겠네요. 그렇기 때문에 사용자가 `seob.dev`에 걸려있는 `example.com` 링크를 클릭한 경우에 전송되는 쿠키도 서드 파티 쿠키로 취급됩니다. 이 때 Referer는 `seob.dev`이니까요.

```html
<html>
  <head>
    <title>seob.dev</title>
    <meta property="og:url" content="https://seob.dev/" />
  </head>
  <body>
    <!-- 아래 링크를 클릭한 경우에 전송되는 쿠키들은 서드 파티 쿠키로 취급됩니다. -->
    <a href="https://example.com/">링크</a>
  </body>
</html>
```

퍼스트 파티 쿠키는 반대로 이해하면 간단합니다. 퍼스트 파티 쿠키는 사용자가 접속한 페이지와 **같은 도메인으로 전송되는 쿠키**를 말합니다.

같은 쿠키라도 사용자가 접속한 페이지에 따라 퍼스트 파티 쿠키로도 부를 수 있고, 서드 파티 쿠키로도 부를 수 있습니다. 앞서 말씀드린 예제에서 `example.com`에 설정된 쿠키는 사용자가 `seob.dev`에 접속해 있을 때는 서드 파티 쿠키였지만, `example.com`에 접속해 있을때는 퍼스트 파티 쿠키입니다.

## 쿠키와 CSRF 문제

쿠키에 별도로 설정을 가하지 않는다면, 크롬을 제외한 브라우저들은 모든 HTTP 요청에 대해서 쿠키를 전송하게 됩니다. 그 요청에는 HTML 문서 요청, HTML 문서에 포함된 이미지 요청, XHR 혹은 Form을 이용한 HTTP 요청등 모든 요청이 포함됩니다.

[CSRF(Cross Site Request Forgery)](https://ko.wikipedia.org/wiki/%EC%82%AC%EC%9D%B4%ED%8A%B8_%EA%B0%84_%EC%9A%94%EC%B2%AD_%EC%9C%84%EC%A1%B0)는 이 문제를 노린 공격입니다. 간단히 소개해보자면 아래와 같은 방식입니다.

1. 공격대상 사이트는 쿠키로 사용자 인증을 수행함.
2. 피해자는 공격 대상 사이트에 이미 로그인 되어있어서 브라우저에 쿠키가 있는 상태.
3. 공격자는 피해자에게 그럴듯한 사이트 링크를 전송하고 누르게 함. (공격대상 사이트와 다른 도메인)
4. 링크를 누르면 HTML 문서가 열리는데, 이 문서는 공격 대상 사이트에 HTTP 요청을 보냄.
5. 이 요청에는 쿠키가 포함(서드 파티 쿠키)되어 있으므로 공격자가 유도한 동작을 실행할 수 있음.

CSRF는 워낙 널리 알려진 문제고 조금만 검색해봐도 잘 설명하고 있는 자료가 많으니 자세히 알고 싶으신 분은 찾아보시는 것을 추천합니다.

바로 뒤에서 말씀드릴 `SameSite`는 이 문제를 해결하기 위해 탄생한 기술입니다.

## `SameSite` 쿠키

`SameSite` 쿠키는 앞서 언급한 서드 파티 쿠키의 보안적 문제를 해결하기 위해 만들어진 기술입니다. 크로스 사이트(Cross-site)로 전송하는 요청의 경우 쿠키의 전송에 제한을 두도록 합니다.

`SameSite` 쿠키의 정책으로 `None`, `Lax`, `Strict` 세 가지 종류를 선택할 수 있고, 각각 동작하는 방식이 다릅니다.

- `None`: `SameSite` 가 탄생하기 전 쿠키와 동작하는 방식이 같습니다. `None`으로 설정된 쿠키의 경우 크로스 사이트 요청의 경우에도 항상 전송됩니다. 즉, 서드 파티 쿠키도 전송됩니다. 따라서, 보안적으로도 `SameSite` 적용을 하지 않은 쿠키와 마찬가지로 문제가 있는 방식입니다.
- `Strict`: 가장 보수적인 정책입니다. `Strict`로 설정된 쿠키는 크로스 사이트 요청에는 항상 전송되지 않습니다. 즉, 서드 파티 쿠키는 전송되지 않고, 퍼스트 파티 쿠키만 전송됩니다.
- `Lax`: `Strict`에 비해 상대적으로 느슨한 정책입니다. `Lax`로 설정된 경우, 대체로 서드 파티 쿠키는 전송되지 않지만, 몇 가지 예외적인 요청에는 전송됩니다.

### `Lax` 쿠키가 전송되는 경우

[The Chromium Projects 의 SameSite 속성을 소개한 게시물](https://www.chromium.org/administrators/policy-list-3/cookie-legacy-samesite-policies)을 보면 다음과 같이 `Lax` 정책을 설명합니다.

> A cookie with "SameSite=Lax" will be sent with a same-site request, or a cross-site top-level navigation with a "safe" HTTP method.

그러니까 같은 웹 사이트일 때는 (당연히) 전송된다는 것이고, 이 외에는 Top Level Navigation(웹 페이지 이동)과, "안전한" HTTP 메서드 요청의 경우 전송된다는 것입니다.

Top Level Navigation에는 유저가 링크(`<a>`)를 클릭하거나, `window.location.replace` 등으로 인해 자동으로 이뤄지는 이동, `302` 리다이렉트를 이용한 이동이 포함됩니다. 하지만 `<iframe>`이나 `<img>`를 문서에 삽입함으로서 발생하는 HTTP 요청은 "Navigation"이라고 할 수 없으니 `Lax` 쿠키가 전송되지 않고, `<iframe>` 안에서 페이지를 이동하는 경우는 "Top Level"이라고 할 수 없으므로 `Lax` 쿠키는 전송되지 않습니다.

또한 "안전하지 않은" `POST`나 `DELETE` 같은 요청의 경우, `Lax` 쿠키는 전송되지 않습니다. 하지만 `GET`처럼 서버의 서버의 상태를 바꾸지 않을 거라고 기대되는 요청에는 `Lax` 쿠키가 전송됩니다.

이 모든 내용은 서드 파티 쿠키에 한하는 것이고, 퍼스트 파티 쿠키는 `Lax`나 `Strict`여도 전송됩니다.

## 브라우저의 `SameSite` 구현

아마 적극적으로 `SameSite` 속성을 사용하고 있는 개발자는 많지 않을 겁니다. 우리가 `SameSite`에 주의를 기울여야 하는 이유는 브라우저들의 동작이 변경되고 있기 때문입니다.

### `Lax` by default

크롬은 `SameSite`를 가장 적극적으로 적용하고 있는 브라우저입니다. 원래 `SameSite`를 명시하지 않은 쿠키는 `SameSite`가 `None`으로 동작했지만, [2020년 2월 4일 크롬 80 버전이 배포](https://www.chromium.org/updates/same-site)되면서 `SameSite`의 기본값이 `Lax`로 변경되었고, 이 변경사항은 운영되고 있는 웹 서비스들에게 많은 영향을 미쳤습니다. 특히 온라인 결제나 [OAuth](https://ko.wikipedia.org/wiki/OAuth)처럼 구현에 크로스 사이트 간의 페이지 전환이 필요한 경우 이러한 변경사항 때문에 원래 제공하던 기능이 제대로 동작하지 않은 경우도 있었습니다. 물론 시간이 꽤 지났기 때문에 현재 운영되는 서비스들은 대부분 대응되어 있을 거에요.

2021년 5월 현재는, 크롬만이 `Lax`를 기본으로 적용하고 있지만 [파이어폭스도 곧 변경될 예정입니다.](https://hacks.mozilla.org/2020/08/changes-to-samesite-cookie-behavior/) 사파리는.. 언제 바뀔지 모르겠네요.

### `Secure` 필수 정책

`SameSite` 속성으로 `None`을 사용하려면 반드시 해당 쿠키는 `Secure` 쿠키여야 합니다. `Secure` 쿠키는 HTTPS가 적용된(그러니까 암호화된) 요청에만 전송되는 쿠키입니다. 이 정책을 구현하는 브라우저도 현재로서는 크롬밖에 없습니다. 그래서 크롬에서는 `SameSite=None`으로 `Set-Cookie`를 사용하면 다음과 같이 쿠키 자체가 제대로 설정되지 않습니다.

!["Secure"가 설정되지 않은 "SameSite=None" 쿠키](./same-site-non-secure.png)

## 쿠키의 미래

크로미엄 블로그의 [Building a more private web: A path towards making third party cookies obsolete](https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html)라는 글에는 다음과 같은 내용이 있습니다.

> ... and we have developed the tools to mitigate workarounds, **we plan to phase out support for third-party cookies in Chrome.**

크롬에서는 장기적으로 서드 파티 쿠키에 대한 지원을 단계적으로 제거할 예정이라는 말이죠. 결국 미래에는 모든 쿠키가 `SameSite=Strict`로 설정된 것처럼 동작하게 된다는 의미인데요.

현재로서는 퍼스트 파티 쿠키가 서드 파티 쿠키의 역할을 모두 대체할 수 없는 상태입니다. 가령 어떤 서비스가 `seob.dev`와 `seob.io` 두 가지 도메인을 모두 사용해서 운영된다고 생각해보세요. 당연히 브라우저는 이 두 도메인을 다른 도메인으로 인식할 것이고, 모든 서드 파티 쿠키가 전송되지 않는다면 이 두 도메인 사이를 왔다갔다 할 때마다 전송되지 않는 쿠키로 인해 문제가 생길 거에요.

구글은 이 문제를 해결하기 위해서 [First-Party Sets](https://github.com/privacycg/first-party-sets)라는 표준을 제안했습니다. First-Party Sets는 여러개의 도메인을 동일한 사이트로 다룰 수 있도록 만드는 기술입니다. `seob.dev`에서 "`seob.io`도 같은 서비스를 제공하고 있어!" 라고 브라우저한테 알려주면 브라우저는 이후에는 그 도메인을 같은 사이트로 관리하는 것이죠. 하지만 아직 표준으로 합의되지 않았고 [반대](https://github.com/w3ctag/design-reviews/issues/342)도 많은 만큼 어떻게 될 지는 모르겠네요.

확실한 건 앞으로는 점점 더 쿠키를 사용하기 까다로워 질 거라는 사실입니다. 지금부터 서드 파티 쿠키를 사용하지 못한다는 전제하에 서비스를 개발하는 게 좋을 것 같네요.

## 더 읽어보기

- [SameSite cookies explained | web.dev](https://web.dev/samesite-cookies-explained/)
- [SameSite cookies - HTTP | MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie/SameSite)

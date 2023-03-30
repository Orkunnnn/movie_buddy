# Movie Buddy 🎬
[![ci][ci_badge]][ci_link]
[![codecov](https://codecov.io/gh/Orkunnnn/movie_buddy/branch/main/graph/badge.svg?token=S0PXNROYW3)](https://codecov.io/gh/Orkunnnn/movie_buddy)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Bu projede elde edilen kazanımlar:
- Test yazma
- Github Actions kullanarak CI sürecini yönetme
- BLoC state management kütüphanesinin kullanımı
- Code coverage sitesi olan CodeCov'a testlerin sonuçları yüklenerek (CI yoluyla) testlerin analizinin yapılması
- Localization
- Lazy Loading
<p float="left; padding=10px">
<img src="https://user-images.githubusercontent.com/73122679/228958228-186a21ad-29c2-44f9-9a59-4c48408bbb12.png" width="300" />
<img src="https://user-images.githubusercontent.com/73122679/228958249-35cc1e64-a1e4-4469-9867-a8272d592472.png" width="300" />
<img src="https://user-images.githubusercontent.com/73122679/228958278-e59d034f-c25f-4397-834c-a7febe73b256.png" width="300" />
</p>

Uygulamada TMDB API kullanıldı. Ayarlar kısmında tema değişikliği ve dil değişikliği seçenekleri bulunmaktadır.

<p float="left; padding=10px">
<img src="https://user-images.githubusercontent.com/73122679/228958825-78132387-442d-424c-afcc-60b2969d88db.png" width="300" />
<img src="https://user-images.githubusercontent.com/73122679/228958876-f53ddd85-a700-43c5-a6be-3145fa2f5114.png" width="300" />
</p>

Dil değişikliği yapıldığında API'dan çekilen veriler (poster, isim vs.) seçilen dile göre değişmektedir.
Filmler lazy loading metodu kulanılarak çekilmektedir.

[ci_badge]: https://github.com/Orkunnnn/movie_buddy/actions/workflows/movie_buddy.yml/badge.svg
[ci_link]: https://github.com/Orkunnnn/movie_buddy/actions
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT

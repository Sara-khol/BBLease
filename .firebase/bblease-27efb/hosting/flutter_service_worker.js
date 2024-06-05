'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "77c8492a4e931d6ef26bfa9434506ed7",
"assets/AssetManifest.bin.json": "7a16e3e1cc5d66247aa5217500f3052d",
"assets/AssetManifest.json": "8c0b373164bfda0aeef29e05e022eba4",
"assets/assets/fonts/PLONI-BLACK-AAA.OTF": "ec617f5e3ddb10eaebf071a0b95edc25",
"assets/assets/fonts/PLONI-BOLD-AAA.TTF": "b845f221fbfeadea69865886d9e3bc3a",
"assets/assets/fonts/PLONI-DEMIBOLD-AAA.OTF": "b62b2dc7075c7d90eff576d19449a362",
"assets/assets/fonts/PLONI-LIGHT-AAA.OTF": "d9ca4abe2d3f497deb64fa57c4ea00b0",
"assets/assets/fonts/PLONI-MEDIUM-AAA.OTF": "3a5a49734aa9638dc0919bce303600bf",
"assets/assets/fonts/PLONI-REGULAR-AAA.ttf": "37e64c4d651549804a731643734982d5",
"assets/assets/fonts/PLONI-ULTRABOLD-AAA.OTF": "ec7e54cc9171d4328fa7104a0005627e",
"assets/assets/fonts/PLONI-ULTRALIGHT-AAA.OTF": "c243ed6bc9f39ddc79a730badbfd03f6",
"assets/assets/fonts/PlusJakartaSans-Bold.ttf": "7dae244963714ee2b16fcbab46661792",
"assets/assets/fonts/PlusJakartaSans-ExtraBold.ttf": "9bfdb6bb1fda2806463b64e44c5eaed9",
"assets/assets/icons/Broken.png": "b3742a14b1c05fd5ba1015cc73f172a9",
"assets/assets/icons/Calendar.png": "d8ba9ef8c77e381a47193dc6e6af1a79",
"assets/assets/icons/car1.png": "7156cc3b518a4f2d63a5a9bd8c898e7c",
"assets/assets/icons/car_icon.png": "a36e9a2df78a7ffbc8519b41b34f24ad",
"assets/assets/icons/car_open_doors.png": "44a007e148d1cd8dd108469ead01e2f9",
"assets/assets/icons/circle.png": "866e31117a51410cfa182a28f817cacc",
"assets/assets/icons/Close.png": "6c6af75748a8750ec5ac800e6b64601f",
"assets/assets/icons/Creditcard.png": "b8941cab88951b35ecce6f540ea978fc",
"assets/assets/icons/done.png": "eca06b4a83a9a3d800402000fa2f0f7b",
"assets/assets/icons/Door.png": "3f6ed7de93522c9f1730e573b19fc0b0",
"assets/assets/icons/driver_license.png": "82bfa10a4da9bd8c8a27fa4e35a47aa8",
"assets/assets/icons/edit.png": "bb514d8d8b8517c680029f1a9488d3d4",
"assets/assets/icons/expansion.png": "3b55accdb38fcfb3e91f47933294fb72",
"assets/assets/icons/f7_creditcard.png": "be51a77634d4a69b4942dc2271ab6e2a",
"assets/assets/icons/Filter.png": "5c2e427fcd47b383dfdd310a83c7d464",
"assets/assets/icons/Frame-30.png": "71b53680e563d8f3a03950bfc84fdd6f",
"assets/assets/icons/Frame.png": "8bc86d697bb95189019dfeb0e84050da",
"assets/assets/icons/Gas.png": "daee09d9252df88c27990a2dcc0ca403",
"assets/assets/icons/heart.png": "553c73df171385726ea44182da1ad54a",
"assets/assets/icons/KM.png": "0c8f1cdb26494333ee682f9cf9d5fb3f",
"assets/assets/icons/Location.png": "85e0baecfb38fbb2b34f3bb3274f18d5",
"assets/assets/icons/lock.png": "20af058c934add4b46a94cb94efb1587",
"assets/assets/icons/maps.png": "add7ec928db423c937b8665d8871de1a",
"assets/assets/icons/mingcute_car-line.png": "e42e5e7134583c24b376fc8d2431739d",
"assets/assets/icons/More.png": "bdffa4ac198e0b22afe81d52a349914a",
"assets/assets/icons/Password.png": "64c8fc09f929d94a399514693a328e01",
"assets/assets/icons/Phone.png": "a28fecf5836b3b728d4db21d6303bb02",
"assets/assets/icons/PhoneW.png": "804632dd6ce414d453fabd6eb8bd1bd2",
"assets/assets/icons/Profil.png": "a00e78ef011ad069eafb985c776e701a",
"assets/assets/icons/Seat.png": "4d813281af410ff6eec65128c27acbfe",
"assets/assets/icons/Smile.png": "38af453354ce7c6e6237e7f16040d6f9",
"assets/assets/icons/solar_sale-linear.png": "e86d020d77f4e71078379b384e09a8e4",
"assets/assets/icons/timePlus.png": "dd058f4f80c92a12847eecb491db5900",
"assets/assets/icons/trash.png": "399018e1caa3e1e10861d0c06e2b4dac",
"assets/assets/icons/unlock.png": "2cdf07730f57c070a00b37061479a171",
"assets/assets/icons/Upload.png": "00adbb782adf536e83a3dd25efe888f9",
"assets/assets/icons/Vector6.png": "79b4590711c6a4416d9c9652acab1285",
"assets/assets/icons/video.png": "898b5ec804178d40b908c01c00714a2f",
"assets/assets/icons/wallet.png": "d81a8dfbdbf4ef7db3a6a90df9398fc6",
"assets/assets/icons/waze.png": "516ab1c329a11f24192d1c25c8a85d0f",
"assets/assets/icons/WazeIcon.png": "344c0faea09e1b80f3d62e3c667eb2a4",
"assets/assets/images/aaa.png": "6f6d44433c31e1052a315ecb4addf79d",
"assets/assets/images/appIcon.png": "38c278cc50f3c24a5a6726af1a4ba5bb",
"assets/assets/images/bag.png": "aba65a606d8d4d24ffb007b82da2fdc6",
"assets/assets/images/BB.png": "2d3538b8982bd00882a7c87f8fd2d49a",
"assets/assets/images/car-available.png": "34a8a1caba699a7e44604447f9682b20",
"assets/assets/images/car-not-available.png": "b2818d2aad48bbe8b2840f97b70f21ea",
"assets/assets/images/car-only.png": "c8580dfc81605106c6ef7b75f2397991",
"assets/assets/images/car2.svg": "34a2f6b624a1b341967656ac36fe2a78",
"assets/assets/images/date_bad.png": "c3a32cd92ad9f9ede3f16231b4324f6f",
"assets/assets/images/Ellipse.png": "8cbcd39c056216f1961c562c0dd09b16",
"assets/assets/images/image1.png": "2cb61b3befb4190e29e35dbaccabc09e",
"assets/assets/images/loading.png": "66b5699129404951c6b97a8a8654a6d8",
"assets/assets/images/more.png": "a83801dd2d290b2c9c2bfda8590cd662",
"assets/assets/images/Phone123.png": "bb7bbf8d27fe9661478fc6dc3027c2b5",
"assets/assets/images/rec.png": "92347fe097558d037bf1343d2fe49a2a",
"assets/assets/images/rect.png": "c01e0a177fa15fd9cfbc9f3824ac7e42",
"assets/assets/images/sucreg.png": "32afe9b471b0dc522bd8869c867d274d",
"assets/assets/images/ticket.png": "f70b38f836f3cf925720985ad390a107",
"assets/assets/mobilefacenet.tflite": "7945c78f4484c99560df461df85baa2f",
"assets/assets/tessdata/eng.traineddata": "57e0df3d84fed9fbf8c7a8e589f8f012",
"assets/assets/tessdata/heb.traineddata": "1d8a02b4f361e7ff61497c5fd84cbaba",
"assets/assets/tessdata_config.json": "a8ccb88ed0305063642c13b5d96efaa6",
"assets/FontManifest.json": "3c7297b6019ffd649d2afee4a15f6e76",
"assets/fonts/MaterialIcons-Regular.otf": "b23271db1be403e8e5c7d7499d5a27e5",
"assets/NOTICES": "e03e74d22cfffc67afc6baf37df73ab4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "ffd063c5ddbbe185f778e7e41fdceb31",
"assets/packages/flutter_tesseract_ocr/images/test_1.jpg": "0a2be1304ca3660cbd959ab65d45f98f",
"assets/packages/flutter_tesseract_ocr/images/test_11.jpg": "0d635defc90b9fa1df0ba9def0eeb9cb",
"assets/packages/flutter_tesseract_ocr/images/test_16.jpg": "35314971c77f915dd1bf0b9579a84960",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "29a14936d5e16796fe8ac04d49d6e95f",
"/": "29a14936d5e16796fe8ac04d49d6e95f",
"main.dart.js": "f71737f2976c510795020d48c7b879cc",
"manifest.json": "b3b6a51552fadc95994ae7df25628625",
"version.json": "d5433610d067aa61da18f5c7d205c301"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

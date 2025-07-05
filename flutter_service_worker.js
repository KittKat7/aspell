'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"manifest.json": "7bb3a04b1a289511b5834819b323ae1b",
"main.dart.js": "308cb081f3fdc434e82a535dea760cf1",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"index.html": "2f784fea949b26b1187b419dc5214083",
"/": "2f784fea949b26b1187b419dc5214083",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/AssetManifest.bin.json": "cf5771e89fa322f21cd13ddab035eccc",
"assets/AssetManifest.bin": "5fd9519d5bfe536f2e12aa1de817840f",
"assets/NOTICES": "2ffd4711f6747c8f1904e1b9689b2876",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/pictures/letters/ascii/ascii_l.png": "d5ddfdba26ef8a66a5381e6c0335bf89",
"assets/assets/pictures/letters/ascii/ascii_b.png": "452898e3e5e206c54f10712a3c36f591",
"assets/assets/pictures/letters/ascii/ascii_n.png": "de57a15cc6dfbfddddae9a9dc73322b0",
"assets/assets/pictures/letters/ascii/ascii_t.png": "fbb76a1ea4d059fb2f87739790eb939e",
"assets/assets/pictures/letters/ascii/ascii_x.png": "c9577782b9e88084a7dd095debac7d7a",
"assets/assets/pictures/letters/ascii/ascii_g.png": "33d4579e1e6d6df43405c099dbf7be31",
"assets/assets/pictures/letters/ascii/ascii_d.png": "5fa0c1c1d867184cdd03f0790050067b",
"assets/assets/pictures/letters/ascii/ascii_z.png": "cf8bc755d7a14134ae743e554acd58b4",
"assets/assets/pictures/letters/ascii/ascii_h.png": "9f265a540b4753204a0790c3f1526ead",
"assets/assets/pictures/letters/ascii/ascii_m.png": "a09bfa2e78b6527f79a711f9a783ddb6",
"assets/assets/pictures/letters/ascii/ascii_p.png": "c62060277176c96e44f8f0d7b0310f66",
"assets/assets/pictures/letters/ascii/ascii_q.png": "57309eca2c430a80f132c678d8c65f20",
"assets/assets/pictures/letters/ascii/ascii_s.png": "4b4330fa87189de9bc6b42ac192be067",
"assets/assets/pictures/letters/ascii/ascii_o.png": "9e3f7fd04491745fa094850ca7cd3bd0",
"assets/assets/pictures/letters/ascii/ascii_c.png": "f0fcd33b90c1d6f1ccd76ae7751aa932",
"assets/assets/pictures/letters/ascii/ascii_f.png": "5ccefd7107ff8f1e01257ebe7c3f686a",
"assets/assets/pictures/letters/ascii/ascii_w.png": "c9edde8ab82e7c9071bc587b458ad220",
"assets/assets/pictures/letters/ascii/ascii_e.png": "9035374185430c9b5a9aaa03853abcf9",
"assets/assets/pictures/letters/ascii/ascii_v.png": "a06f37eb553feb46b11e9cae84dd1468",
"assets/assets/pictures/letters/ascii/ascii_j.png": "2cc06838c49ec7707ec5cb8a5557045d",
"assets/assets/pictures/letters/ascii/ascii_k.png": "7b76b5eb605ae32e927553a9e0483408",
"assets/assets/pictures/letters/ascii/ascii_r.png": "d5f5bc8db5f5b336eae58d0d00073f18",
"assets/assets/pictures/letters/ascii/ascii_u.png": "2727d4b977dd24ce89a7a1218e15b875",
"assets/assets/pictures/letters/ascii/ascii_a.png": "786467cc9ab0da7efc29c7d9cfdcae08",
"assets/assets/pictures/letters/ascii/ascii_i.png": "32e05457dd04221c1834951fd73fd828",
"assets/assets/pictures/letters/ascii/ascii_y.png": "cda24504c27ee7bbe6d21c9a50e22f92",
"assets/assets/pictures/letters/avery/avery_l.png": "ab839c91df339a7952ebff0528847d39",
"assets/assets/pictures/letters/avery/avery_e.png": "de2d7702c84b2530f0eafa489e106474",
"assets/assets/pictures/letters/avery/avery_f.png": "200ec062a49acda7573cb08df511a1a8",
"assets/assets/pictures/letters/avery/avery_p.png": "a26a6ad8b3748fc21b2fc04b7fd44bdf",
"assets/assets/pictures/letters/avery/avery_k.png": "f2963e37412dc8f6a8d27eb756cdc8f7",
"assets/assets/pictures/letters/avery/avery_u.png": "00810f7fe6f715dee8db1ab9f88270a7",
"assets/assets/pictures/letters/avery/avery_x.png": "b8f37e3f5689ba8dcc3edde3150331bc",
"assets/assets/pictures/letters/avery/avery_j.png": "29473857b3f5472121ddbb6ce881fdc2",
"assets/assets/pictures/letters/avery/avery_h.png": "a8891342949941f4aaae209d541a52c4",
"assets/assets/pictures/letters/avery/avery_m.png": "0d551fdcb3379bb1e5f4b687526312a6",
"assets/assets/pictures/letters/avery/avery_i.png": "adf25ea262c7cce90d838803a2c5c329",
"assets/assets/pictures/letters/avery/avery_s.png": "0fccc3f88095196f5e8b40d7905f950e",
"assets/assets/pictures/letters/avery/avery_n.png": "75e2993a7f20f34f505dd24664bd3559",
"assets/assets/pictures/letters/avery/avery_w.png": "8c98d6be5d556c7b947799600e34adf6",
"assets/assets/pictures/letters/avery/avery_r.png": "443df65e030305b8ef7a261671ee7410",
"assets/assets/pictures/letters/avery/avery_y.png": "90c09afb23856d9fe00f9cd5fdff996f",
"assets/assets/pictures/letters/avery/avery_b.png": "caae72a7681bc3aaa2b6a14647c1f5d3",
"assets/assets/pictures/letters/avery/avery_z.png": "7f11df5d0714d42ee516a9ebd5974c00",
"assets/assets/pictures/letters/avery/avery_g.png": "0698479bd3f4f0f0d496a42a797c83bc",
"assets/assets/pictures/letters/avery/avery_c.png": "75e8eea8b07924ce123827148689c41e",
"assets/assets/pictures/letters/avery/avery_v.png": "d24284fec0328ca78f5d663f1d57f262",
"assets/assets/pictures/letters/avery/avery_d.png": "e2679252d47f69b2fbe478cd2c5aa213",
"assets/assets/pictures/letters/avery/avery_q.png": "9119beb50f5235f57d56ad6b9f9aa2c9",
"assets/assets/pictures/letters/avery/avery_t.png": "edbc290a6ba6232b6fbece0c225389fc",
"assets/assets/pictures/letters/avery/avery_a.png": "776c78a58221902ac7f6fa1a807dcbff",
"assets/assets/pictures/letters/avery/avery_o.png": "60504ae9b97615cbbfcdbc39e82f58fc",
"assets/assets/pictures/logo.png": "1e35baef92cd82b452b5f202f55c8c02",
"assets/assets/pictures/logo_padded.png": "1d08d269cb9ef0ca956aa980f2744fd5",
"assets/assets/pictures/loading.jpg": "6c58242211a5fb30207dbe6b06124f13",
"assets/assets/pictures/logo%2520-%2520Copy.png": "3693356975bb7df5fcdf20e7c25e05f8",
"assets/assets/pictures/cross.png": "4b039255436b512e61374f15158b62e8",
"assets/assets/pictures/check.png": "f1384aa387e54a6cafb09f7b5019d5a5",
"assets/assets/pictures/logo_background.png": "7319fcf8f9c03bb9013880393affe975",
"assets/assets/texts/words_original.txt": "eec52672288b2beb30d9af073ce15572",
"assets/assets/texts/words_LICENSE.txt": "7bc929f5272fa8d8281b9a9fd6fd1a7b",
"assets/assets/texts/words.txt": "cf2b0a39202081ebd0cfcac5d49c87cc",
"assets/assets/roboto-mono/RobotoMono-VariableFont_wght.ttf": "336102a48d996db3d945a346b1790b1f",
"assets/AssetManifest.json": "f6060cd8f2f5b676e0443fb232eb6c39",
"assets/fonts/MaterialIcons-Regular.otf": "a4ec2389c2a6b7d6bfeafd7c87f4a866",
"assets/FontManifest.json": "a775bae0c178a6c92d4af721b8172e38",
"favicon.png": "a391b60282024aa29b54f961aa8c0629",
"icons/Icon-512.png": "175e1192812d3bc9a0bdc93d2b99698f",
"icons/Icon-maskable-192.png": "8fea801889d5eb797636b0a90a48c6e5",
"icons/Icon-192.png": "8fea801889d5eb797636b0a90a48c6e5",
"icons/Icon-maskable-512.png": "175e1192812d3bc9a0bdc93d2b99698f",
"flutter_bootstrap.js": "af3213821a50c086d9a9b27c37bd3a5a",
"version.json": "a553d9ac40567fbc9128ab8aea2e8afb"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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

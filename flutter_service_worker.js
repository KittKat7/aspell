'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"index.html": "2f784fea949b26b1187b419dc5214083",
"/": "2f784fea949b26b1187b419dc5214083",
"assets/NOTICES": "e4603e3a0c398ee3e55f7b429ac5f64e",
"assets/assets/texts/words.txt": "6a37f21711e2489b879e7e17d744082a",
"assets/assets/roboto-mono/RobotoMono-VariableFont_wght.ttf": "336102a48d996db3d945a346b1790b1f",
"assets/assets/pictures/letters/averyb/y1.jpg": "d6f607c6631cc5a266b8dfb52035c2e4",
"assets/assets/pictures/letters/averyb/v1.jpg": "d88e5679b4e3d36b0b1700dea6567725",
"assets/assets/pictures/letters/averyb/z1.jpg": "3ab72d4f93cd37690df60b3cc9233211",
"assets/assets/pictures/letters/averyb/c1.jpg": "acde0659860c8fa54f998be521cd7140",
"assets/assets/pictures/letters/averyb/h1.jpg": "f2a5f575761b6f1394dc43057c97d2f5",
"assets/assets/pictures/letters/averyb/k1.jpg": "303090d153f76f9c0a13b304f78e0330",
"assets/assets/pictures/letters/averyb/a1.jpg": "eb9e75e4c6122895f25dcfa2b8ff34da",
"assets/assets/pictures/letters/averyb/x1.jpg": "4bcc4d1a90ecc5ebfb4f5a78608c174c",
"assets/assets/pictures/letters/averyb/u1.jpg": "6fb5efdb73907c17253e358a5b5162a2",
"assets/assets/pictures/letters/averyb/w1.jpg": "bfeb0650feb959af3d7a69045995ccec",
"assets/assets/pictures/letters/averyb/t1.jpg": "862d67d8bc8724efc6af789b94014fb6",
"assets/assets/pictures/letters/averyb/f1.jpg": "1fd2f7a91a5ff0f54791ef3ba815472d",
"assets/assets/pictures/letters/averyb/m1.jpg": "86d855983f8e95c3159b19bf6b48fd2d",
"assets/assets/pictures/letters/averyb/q1.jpg": "563ccbd707be28717c08effaa16ae577",
"assets/assets/pictures/letters/averyb/j1.jpg": "ea57bfdccd5c86cc36e1dc7705a61aa2",
"assets/assets/pictures/letters/averyb/l1.jpg": "3e108f8c9cbac1fd0a16eeefcded4e22",
"assets/assets/pictures/letters/averyb/p1.jpg": "4988ddf056599281a09740fb473708de",
"assets/assets/pictures/letters/averyb/o1.jpg": "ea57b4f3355f4f89c40a7f548ac0bbeb",
"assets/assets/pictures/letters/averyb/d1.jpg": "624821d27f66d762c7279cbf1b1c0b0a",
"assets/assets/pictures/letters/averyb/s1.jpg": "8d0412520fdb7304695b1beafb97fcec",
"assets/assets/pictures/letters/averyb/b1.jpg": "369683a29a03ae49b3a7d6541d5a7893",
"assets/assets/pictures/letters/averyb/i1.jpg": "d1347e3a5262eb235799a7c4b817fd9f",
"assets/assets/pictures/letters/averyb/e1.jpg": "ad2dab0d925c228925d13861553b7078",
"assets/assets/pictures/letters/averyb/r1.jpg": "bc81ccd94f2198d7d99ec8e31f231f0f",
"assets/assets/pictures/letters/averyb/g1.jpg": "6114f06359de8834a641dbdc808e4ace",
"assets/assets/pictures/letters/averyb/j.jpg": "b41b8440e53d4ac3887b670d5c0a432f",
"assets/assets/pictures/letters/averyb/z.jpg": "577041f4a5980edfc7413569c1d12292",
"assets/assets/pictures/letters/averyb/n1.jpg": "7152743a9ca96cb988e215aada158f65",
"assets/assets/pictures/letters/avery_r.png": "c436d98649bda0bb1d289f9e4c0487f6",
"assets/assets/pictures/letters/avery_b.png": "9abfd97b6ed8b2cf74de069d6cf2a01e",
"assets/assets/pictures/letters/avery_z.png": "8da9e104765e90b2fedfa53d0583adbc",
"assets/assets/pictures/letters/avery_x.png": "9f3d55a2441b946a3f819c05ad446577",
"assets/assets/pictures/letters/avery_e.png": "899cd6bcefb05a7e2adaf13c2bdf8046",
"assets/assets/pictures/letters/avery_j.png": "c88802d83c224ad97e0d5ac508ec4d22",
"assets/assets/pictures/letters/avery_i.png": "bbd9581eb8bc7fe1167fc9f1427c240a",
"assets/assets/pictures/letters/avery_w.png": "ecbe29b152891e251fa2cc3a2491cb67",
"assets/assets/pictures/letters/avery_y.png": "b1546a79c95e800aadeedb22489bac03",
"assets/assets/pictures/letters/avery_k.png": "dd58e4ca35e866928d526073af1353dc",
"assets/assets/pictures/letters/avery_l.png": "cb24f15e25adfaccdb85fa3687d80ef9",
"assets/assets/pictures/letters/avery_v.png": "84a23ceceaad978d31f59d3432444ced",
"assets/assets/pictures/letters/avery_u.png": "91796b071b5f06dbad5fee9a1a01fc59",
"assets/assets/pictures/letters/avery_p.png": "4d383d60800883f8bb8237b00f9a36e2",
"assets/assets/pictures/letters/avery_s.png": "b1ac5c73470e1518fc299f04b0850b2a",
"assets/assets/pictures/letters/avery_n.png": "b730c2a2ddd0c67f02b00756184f6950",
"assets/assets/pictures/letters/avery_h.png": "e96a7bd64d37f46d8c4cc41a67ad84ab",
"assets/assets/pictures/letters/avery_g.png": "b9b707dd3bcf4974190c0745b00f18e6",
"assets/assets/pictures/letters/avery_q.png": "ba85635ed95f13aa60ae8ddbc5b92b2e",
"assets/assets/pictures/letters/avery_f.png": "526a3ccd07c59d135d5fa7f17c7b47de",
"assets/assets/pictures/letters/avery_d.png": "1973b007e3643864e030ab0de0d0b3d2",
"assets/assets/pictures/letters/avery_m.png": "5f6f4575ec5f535afe6b48e6aa1ba497",
"assets/assets/pictures/letters/avery_c.png": "cc780100f042745693391b3f849822b1",
"assets/assets/pictures/letters/avery_o.png": "779b798c56ada344bb5575e3609dd254",
"assets/assets/pictures/letters/avery_a.png": "2cbbe65ee4f46bdc7ea7d48a5520d184",
"assets/assets/pictures/letters/avery_t.png": "1b7a06132db92182b2a9cdf0690feec0",
"assets/assets/pictures/logo_background.png": "7319fcf8f9c03bb9013880393affe975",
"assets/assets/pictures/logo.png": "1e35baef92cd82b452b5f202f55c8c02",
"assets/assets/pictures/check.png": "f1384aa387e54a6cafb09f7b5019d5a5",
"assets/assets/pictures/logo%2520-%2520Copy.png": "3693356975bb7df5fcdf20e7c25e05f8",
"assets/assets/pictures/cross.png": "4b039255436b512e61374f15158b62e8",
"assets/assets/pictures/loading.jpg": "6c58242211a5fb30207dbe6b06124f13",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1057d3fa55ddc4f8847c20432a5cbe67",
"assets/fonts/MaterialIcons-Regular.otf": "0232b47030727b4057a0a479eefd4f84",
"assets/FontManifest.json": "a775bae0c178a6c92d4af721b8172e38",
"assets/AssetManifest.bin.json": "fca39632d2cd638ef8a9c2524606af5c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.json": "b4821a9f3bd039430f4b4509f1049f51",
"version.json": "016a6fd46edea7a204c79e4e79378f8e",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"main.dart.js": "a118333d95b3a3e456df29493f0b5e14",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "3d82ddd2cf4dbae8c875befa55d36e4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "7675817c6f0be0b460869131063543a7"};
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

--- a/src/build_helper/src/ci.rs
+++ b/src/build_helper/src/ci.rs
@@ -9,9 +9,6 @@
 impl CiEnv {
     /// Obtains the current CI environment.
     pub fn current() -> CiEnv {
-        if std::env::var("GITHUB_ACTIONS").map_or(false, |e| e == "true") {
-            CiEnv::GitHubActions
-        } else {
             CiEnv::None
         }
     }

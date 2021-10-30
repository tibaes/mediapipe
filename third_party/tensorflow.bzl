load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def mediapipe_tensorflow():
    # Needed by TensorFlow
    http_archive(
        name = "io_bazel_rules_closure",
        sha256 = "e0a111000aeed2051f29fcc7a3f83be3ad8c6c93c186e64beb1ad313f0c7f9f9",
        strip_prefix = "rules_closure-cf1e44edb908e9616030cc83d085989b8e6cd6df",
        urls = [
            "http://mirror.tensorflow.org/github.com/bazelbuild/rules_closure/archive/cf1e44edb908e9616030cc83d085989b8e6cd6df.tar.gz",
            "https://github.com/bazelbuild/rules_closure/archive/cf1e44edb908e9616030cc83d085989b8e6cd6df.tar.gz",  # 2019-04-04
        ],
    )

    # Tensorflow repo should always go after the other external dependencies.
    # 2021-07-29
    _TENSORFLOW_GIT_COMMIT = "52a2905cbc21034766c08041933053178c5d10e3"
    _TENSORFLOW_SHA256 = "06d4691bcdb700f3275fa0971a1585221c2b9f3dffe867963be565a6643d7f56"
    http_archive(
        name = "org_tensorflow",
        urls = [
        "https://github.com/tensorflow/tensorflow/archive/%s.tar.gz" % _TENSORFLOW_GIT_COMMIT,
        ],
        patches = [
            "@//third_party:org_tensorflow_compatibility_fixes.diff",
            "@//third_party:org_tensorflow_objc_cxx17.diff",
            # Diff is generated with a script, don't update it manually.
            "@//third_party:org_tensorflow_custom_ops.diff",
        ],
        patch_args = [
            "-p1",
        ],
        strip_prefix = "tensorflow-%s" % _TENSORFLOW_GIT_COMMIT,
        sha256 = _TENSORFLOW_SHA256,
    )

    # Edge TPU
    http_archive(
    name = "libedgetpu",
    sha256 = "14d5527a943a25bc648c28a9961f954f70ba4d79c0a9ca5ae226e1831d72fe80",
    strip_prefix = "libedgetpu-3164995622300286ef2bb14d7fdc2792dae045b7",
    urls = [
        "https://github.com/google-coral/libedgetpu/archive/3164995622300286ef2bb14d7fdc2792dae045b7.tar.gz"
    ],
    )


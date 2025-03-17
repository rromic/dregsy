# Changelog

## `0.5.2`
- upgrades:
    + *Go* 1.24.1
    + latest *Ubuntu 24.04* and *Alpine 3.21*
    + *Skopeo* 1.18.0
    + misc. lib upgrades for remediation of CVEs in dependencies

## `0.5.1`
- fixes:
    + check for `gcr.io` as domain, as well as for `.gcr.io` as domain suffix (PR #110)
    + corrected logic for setting *GCR* refresher, to allow using public *GCR* without authentication (PR #109)
- upgrades:
    + *Go* 1.21.6
    + latest *Ubuntu 22.04* and *Alpine 3.18*
    + *Skopeo* 1.14.1
    + misc. lib upgrades for remediation of CVEs in dependencies
- pre-built binaries for a few architectures are now also provided with each release; however, except for `linux_amd64` provided as untested! (#101)

## `0.5.0`
- changed behavior: tag pruning no longer removes verbatim tags
- support public *ECR* repos (issue #60)
- allow digests in tags (issue #86)
- use provided credentials with *GCR* (PR #92)
- support latest count limit for tag sets (issue #96)
- restart on config file change and receiving `SIGHUP` (issue #98)
- upgrades:
    + *Go* 1.20.2
    + latest *Ubuntu 22.04* and *Alpine 3.17*
    + *Skopeo* 1.11.2

## `0.4.5`
- upgrades:
    + *Go* 1.20.1
    + latest *Ubuntu 22.04* and *Alpine 3.17*
    + *Skopeo* 1.11.1
    + misc. lib upgrades for CVE remediation

## `0.4.4`
- use `Metadata-Flavor` header when checking for *Google* metadata server (PR #82)
- upgrades:
    + *Go* 1.18.8
    + latest *Ubuntu 22.04* (remediates [CVE-2022-3602](https://ubuntu.com/security/CVE-2022-3602) and [CVE-2022-3786](https://ubuntu.com/security/CVE-2022-3786))
    + *Alpine 3.16*
    + *Skopeo* 1.9.3

## `0.4.3`
- support for pruning filtered tag sets (issue #72, *alpha* feature)
- added `-run` option for filtering tasks to run (issue #59)
- support for platform selection when syncing from multi-platform images (issue #43, *alpha* feature)
- raised default *Docker* API version to `1.41`
- adjusted build to also work on MacOS+M1
- remediation of CVEs in dependencies:
    + [Improper Input Validation in GoGo Protobuf](https://github.com/advisories/GHSA-c3h9-896r-86jm)
    + [containerd CRI plugin: Insecure handling of image volumes](https://github.com/advisories/GHSA-crp2-qrr5-8pq7)
    + [containerd CRI plugin: Host memory exhaustion through ExecSync](https://github.com/advisories/GHSA-5ffw-gxpp-mxpf)
- upgrades:
    + *Go* 1.18
    + *Ubuntu 22.04* and *Alpine 3.15*
    + *Skopeo* 1.8.0 (own build)

## `0.4.2`
- remediation of CVEs in dependencies:
    + [OCI Manifest Type Confusion Issue](https://github.com/advisories/GHSA-qq97-vm5h-rrhg)
    + [Ambiguous OCI manifest parsing](https://github.com/advisories/GHSA-5j5w-g665-5m35)
    + [Clarify `mediaType` handling](https://github.com/advisories/GHSA-77vh-xpmg-72qh)
    + [Insufficiently restricted permissions on plugin directories](https://github.com/advisories/GHSA-c2h3-6mxw-7mvq)
- upgrades:
    + switched to *Go* 1.17
    + *Ubuntu 20.04* and *Alpine 3.14* to latest container images
- fixes:
    + building on non-*Linux* platforms (issue #61)

## `0.4.1`
- remediation of CVEs in dependencies:
    + [CVE-2020-26160](https://github.com/advisories/GHSA-w73w-5m7g-f7qc), `github.com/dgrijalva/jwt-go`
    + [GHSA-c72p-9xmj-rx3w](https://github.com/advisories/GHSA-c72p-9xmj-rx3w), `github.com/containerd/containerd`
- upgrades:
    + *Skopeo* to 1.3.1 (*Alpine*) & 1.3.0 (*Ubuntu*)
    + *Alpine* to 3.14.0
    + *Ubuntu 20.04* to latest container image

## `0.4.0`
- support for image matching (issue #16, *alpha* feature)
- tag filtering with *semver* and *regex* (issue #22, *alpha* feature)
- support token based authentication for *Google Artifact Registry* (issue #51)
- doc updates & corrections

## `0.3.6`
- added container image based on *Ubuntu 20.04* (issue #47)

## `0.3.5`
- upgraded to *Alpine* 3.13.1 & *Skopeo* 1.2.1 (issue #29)

## `0.3.4`
- allow to deactivate authentication for public images on *GCR* (issue #37)

## `0.3.3`
- fixed stopping of one-off tasks (issue #35)

## `0.3.2`
- support for *Google Container Registry* (issue #30)
- switched to `logrus` for logging (issue #32)
- added basic e2e tests (issue #28)
- code refactored

## `0.3.1`
- added more info to error messages during image ref matching (*Docker* relay, issue #18)
- upgraded to *Skopeo* 0.2.0, switched to using *Skopeo*'s `list-tags` command (issue #13)
- documentation updates

## `0.3.0`
- switched to *Go* 1.13 & modules
- removed *Skopeo* submodule: The *Skopeo* project is [phasing out static builds](https://github.com/containers/skopeo/issues/755), so the previous approach of building a `FROM scratch` image for *dregsy* with just the two binaries no longer works. Instead, *Alpine* is now used as the base, and *Skopeo* is installed during image build via `apk` (see `Dockerfile` for version information).

    **Important - breaking change:** The `dregsy` binary is now located at `/usr/local/bin` inside the image. You may need to adjust how you invoke *dregsy*.

- support for *AWS* China *ECR*
- doc updates
- fix for issue #4: canonicalize image refs before matching

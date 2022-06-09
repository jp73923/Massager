![BidMachine iOS](https://appodeal-ios.s3-us-west-1.amazonaws.com/docs/bidmachine.png)

## BidMachine Adaptors

- [Working with the repository](#user-content-working-with-the-repository)
- [Release algorithm](#user-content-release-algorithm)
- [Adapter versions](#user-content-adapter-versions)

## Working with the repository

1. Clone BidMacine repository
```shell
  ~:git clone --recursive git@github.com:bidmachine/BidMachine-iOS-SDK.git
```

2. Go to the submodule folder
```shell
  ~:cd BidMachine-iOS-Adaptors
```

3. Switch to the desired branch
```shell
  ~:git checkout master
```

3. Create new branch
```shell
  ~:git checkout -b "beta"
```

4. Save changes
```shell
  ~:git add .
  ~:git commit -m ""
```

5. Push changes
```shell
  ~:git push
```
or

```shell
  ~:git push --recurse-submodules=on-demand
```

## Release algorithm

1. Edit *ANYAdapter/ANYAdapter.podspec*. Change pod version to actual tag. Save

2. Edit *ANYAdapter/CHANGELOG.md*. Add a description to the update. Save

3. Edit *README.md*. Adapter version [field](#user-content-adapter-versions)

4. Save changes
```shell
  ~:git add .
  ~:git commit -m ""
```

5. Push changes
```shell
  ~:git push
```

6. Create tag with correct description 
```shell
  ~:git tag -a vANYAdapter-X.Y.Z.B -m "Add some cool feature"
  ~:git push origin vANYAdapter-X.Y.Z.B
```
`NOTE!` Where *ANYAdapter* - podspec.name, *X.Y.Z* - BDMSdk version, *B* - adapter version

`NOTE!` If you build release from branch different to master, please set *-Beta* suffix to tag version: *vANYAdapter-X.Y.Z.B-Beta*

## Adapter versions

- *BDMAdColonyAdapter* 	= **4.7.2**
- *BDMAmazonAdapter* 	= **3.3.0**
- *BDMCriteoAdapter* 	= **4.0.1**
- *BDMFacebookAdapter* 	= **6.9.0**
- *BDMMyTargetAdapter* 	= **5.15.0**
- *BDMSmaatoAdapter* 	= **21.6.17**
- *BDMTapjoyAdapter* 	= **12.8.0**
- *BDMVungleAdapter* 	= **6.10.6**
- *BDMIABAdapter*         = **~> 1.5.0**
- *BDMPangleAdapter*     = **3.7.0.7**

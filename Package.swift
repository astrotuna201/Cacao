import PackageDescription

let package = Package(
    name: "Cacao",
    targets: [
                 Target(
                    name: "Demo",
                    dependencies: [.Target(name: "Cacao")]),
                 Target(
                    name: "Cacao")
    ],
    
    exclude: ["Xcode"]
)



#if os(OSX)
  let dependencies : [Package.Dependency] = [
          .Package(url: "https://github.com/astrotuna201/Silica.git", majorVersion: 1),
          .Package(url: "https://github.com/astrotuna201/CSDL2Mac.git", majorVersion: 1)
      ]
  package.dependencies.append(contentsOf: dependencies)
#else
  let dependencies : [Package.Dependency] = [
          .Package(url: "https://github.com/astrotuna201/Silica.git", majorVersion: 1),
          .Package(url: "https://github.com/astrotuna201/CSDL2.git", majorVersion: 1)
      ]
  package.dependencies.append(contentsOf: dependencies)
#endif

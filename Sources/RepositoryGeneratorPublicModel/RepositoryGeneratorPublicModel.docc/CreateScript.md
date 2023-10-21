# Create your own script

How to create your own script to generate source code.

## Create your command-Line tool with Xcode

- Start by creating a new command-line tool with Xcode (File > New > Package) then choose the macOS tab and click on Command-Line Tool.
- Add RepositoryGeneratorPublicModel dependency to your swift package
- Add the necessary argument to your command-line tool and decode the global model:

```main.swift
import Foundation
import ArgumentParser
import RepositoryGeneratorPublicModel

@main
struct CommandLineToolName: ParsableCommand {
    @Argument(help: "Repository title")
    var repositoryTitle: String

    @Argument(help: "Operations model [RepositoryGeneratorPublicModel.Operation]")
    var operationsEncodedModel: String
    
    @Argument(help: "Repository generation directory absolute url")
    var repositoryGenerationPath: String

    mutating func run() throws {
        guard let json = operationsEncodedModel.data(using: .utf8) else {
            return
        }
        let globalModel = try JSONDecoder().decode(RepositoryGeneratorPublicModel.GlobalModel.self, from: json)
        print("hello")
    }
}
```

## Create your script using Xcodegen

### [XcodeGen](https://github.com/yonaskolb/XcodeGen)

Install Xcodegen then add the following file to a folder

- project-folder\project.yml

```project.yml
name: MyCommandLineTool
options:
  bundleIdPrefix: com.myapp
packages:
  ArgumentParser:
    url: https://github.com/apple/swift-argument-parser.git
    from: 1.0.0
  RepositoryGeneratorPublicModel:
    url: https://github.com/kmonde89/RepositoryGeneratorPublicModel
    from: 0.0.17
targets:
  MyApp:
    type: tool
    platform: macOS
    deploymentTarget: "13.3"
    sources: [Sources]
    settings:
      configs:
        debug:
          CUSTOM_BUILD_SETTING: my_debug_value
        release:
          CUSTOM_BUILD_SETTING: my_release_value
    dependencies:
      - package: ArgumentParser
      - package: RepositoryGeneratorPublicModel
```

- project-folder\Sources\main.swift

```main.swift
import Foundation
import ArgumentParser
import RepositoryGeneratorPublicModel

@main
struct CommandLineToolName: ParsableCommand {
    @Argument(help: "Repository title")
    var repositoryTitle: String

    @Argument(help: "Operations model [RepositoryGeneratorPublicModel.Operation]")
    var operationsEncodedModel: String
    
    @Argument(help: "Repository generation directory absolute url")
    var repositoryGenerationPath: String

    mutating func run() throws {
        guard let json = operationsEncodedModel.data(using: .utf8) else {
            return
        }
        let globalModel = try JSONDecoder().decode(RepositoryGeneratorPublicModel.GlobalModel.self, from: json)
        print("hello")
    }
}
```

Then create the base for the command line project running this command
```
xcodegen
```

### Featured

@Links(visualStyle: detailedGrid) {
    - <doc:RepoScribe>
    - <doc:RepositoryGeneratorPublicModel>
}

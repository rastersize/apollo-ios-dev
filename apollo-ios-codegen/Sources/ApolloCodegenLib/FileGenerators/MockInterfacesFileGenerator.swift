import Foundation
import IR
import OrderedCollections
import GraphQLCompiler

/// Generates a file providing the ability to mock the GraphQLInterfaceTypes in a schema
/// for testing purposes.
struct MockInterfacesFileGenerator: FileGenerator {

  let graphQLInterfaces: OrderedSet<GraphQLInterfaceType>

  let config: ApolloCodegen.ConfigurationContext

  init?(ir: IRBuilder, config: ApolloCodegen.ConfigurationContext) {
    let interfaces = ir.schema.referencedTypes.interfaces
    guard !interfaces.isEmpty else { return nil }
    self.graphQLInterfaces = interfaces
    self.config = config
  }

  var template: any TemplateRenderer {
    MockInterfacesTemplate(
      graphQLInterfaces: graphQLInterfaces,
      config: config
    )
  }

  var target: FileTarget { .testMock }
  var fileName: String { "MockObject+Interfaces" }
}

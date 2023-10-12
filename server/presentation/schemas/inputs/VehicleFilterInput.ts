import { GraphQLInputObjectType, GraphQLInt } from 'graphql';

export default new GraphQLInputObjectType({
  name: 'VehicleFilterInput',
  description: 'Description',
  fields: {
    maxKilometrage: {
        type: GraphQLInt,
        description: 'The maximum kilometrage of the car'
    },
    minimumPlaces: {
        type: GraphQLInt,
        description: 'The minimum places in the car'
    }
  }
});
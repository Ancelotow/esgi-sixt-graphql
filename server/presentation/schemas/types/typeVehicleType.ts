import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import VehicleType from "../../../domain/entities/vehicleType";

const typeVehicleType = new GraphQLObjectType<VehicleType>({
    name: 'VehicleType',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
    },
});

export {typeVehicleType}

import {
    GraphQLFloat,
    GraphQLID,
    GraphQLInt,
    GraphQLList,
    GraphQLNonNull,
    GraphQLObjectType,
    GraphQLString
} from "graphql";
import Rent from "../../../domain/entities/rent";
import VehicleController from "../../../domain/controllers/vehicleController";
import {statusType} from "./statusType";
import vehicleInterface from "../interfaces/Vehicle";

const rentType = new GraphQLObjectType<Rent>({
    name: 'Rent',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        nbDays: { type: GraphQLNonNull(GraphQLInt) },
        amountExcluding: { type: GraphQLNonNull(GraphQLFloat) },
        vatRate: { type: GraphQLNonNull(GraphQLFloat) },
        rentAt: { type: GraphQLNonNull(GraphQLString) },
        createdAt: { type: GraphQLNonNull(GraphQLString) },
        vehicle: {
            type: GraphQLNonNull(vehicleInterface),
            resolve: (rent) => VehicleController.getById(rent.vehicleId)
        },
        status: {
            type: GraphQLNonNull(statusType),
            resolve: (rent) => rent.statusId
        }
    },
})

export {rentType}

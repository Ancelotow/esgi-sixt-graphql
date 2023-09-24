import {GraphQLID, GraphQLInt, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import {brandType} from "./brandType";
import Model from "../../../domain/entities/model";
import BrandController from "../../../domain/controllers/brandController";
import {typeVehicleType} from "./typeVehicleType";
import VehicleTypeController from "../../../domain/controllers/vehicleTypeController";

const modelType = new GraphQLObjectType<Model>({
    name: 'Model',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
        releaseYear: { type: GraphQLNonNull(GraphQLInt) },
        brand: {
            type: GraphQLNonNull(brandType),
            resolve: (model) => BrandController.getById(model.brandId)
        },
        type: {
            type: GraphQLNonNull(typeVehicleType),
            resolve: (model) => VehicleTypeController.getById(model.typeId)
        }
    },
});

export {modelType}

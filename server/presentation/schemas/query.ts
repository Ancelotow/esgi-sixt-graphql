import BrandController from "../../domain/controllers/brandController";
import {GraphQLList, GraphQLNonNull, GraphQLObjectType} from "graphql";
import {brandType} from "./types/brandType";
import {typeVehicleType} from "./types/typeVehicleType";
import VehicleTypeController from "../../domain/controllers/vehicleTypeController";
import {modelType} from "./types/modelType";
import ModelController from "../../domain/controllers/modelController";
import {colorType} from "./types/colorType";
import ColorController from "../../domain/controllers/colorController";
import {townType} from "./types/townType";
import TownController from "../../domain/controllers/townController";
import {centerType} from "./types/centerType";
import CenterController from "../../domain/controllers/centerController";
import {vehicleType} from "./types/vehicleType";
import VehicleController from "../../domain/controllers/vehicleController";
import {fuelType} from "./types/fuelType";
import FuelController from "../../domain/controllers/fuelController";
import {rentType} from "./types/rentType";
import RentController from "../../domain/controllers/rentController";
import {connectionFromArraySlice, forwardConnectionArgs, getOffsetWithDefault} from "graphql-relay";
import {rentConnection} from "./connection/rentConnection";
import {vehicleConnection} from "./connection/vehicleConnection";

export default new GraphQLObjectType({
    name: 'Query',
    fields: {
        brands: {
            type: new GraphQLList(brandType),
            resolve: () => BrandController.getAll()
        },
        models: {
            type: new GraphQLList(modelType),
            resolve: () => ModelController.getAll()
        },
        vehicleTypes: {
            type: new GraphQLList(typeVehicleType),
            resolve: () => VehicleTypeController.getAll()
        },
        colors: {
            type: new GraphQLList(colorType),
            resolve: () => ColorController.getAll()
        },
        towns: {
            type: new GraphQLList(townType),
            resolve: () => TownController.getAll()
        },
        centers: {
            type: new GraphQLList(centerType),
            resolve: () => CenterController.getAll()
        },
        vehicles: {
            type: new GraphQLNonNull(vehicleConnection),
            args: forwardConnectionArgs,
            resolve: async (_, args) => {
                const offset = getOffsetWithDefault(args.after, 0);
                let vehicles = await  VehicleController.getAll()
                return connectionFromArraySlice(vehicles, args, {
                    sliceStart: offset,
                    arrayLength: vehicles.length,
                })
            }
        },
        fuels: {
            type: new GraphQLList(fuelType),
            resolve: () => FuelController.getAll()
        },
        rents: {
            type: new GraphQLNonNull(rentConnection),
            args: forwardConnectionArgs,
            resolve: async (_, args) => {
                const offset = getOffsetWithDefault(args.after, 0);
                let rents = await  RentController.getAll()
                return connectionFromArraySlice(rents, args, {
                    sliceStart: offset,
                    arrayLength: rents.length,
                })
            }
        }
    }
});

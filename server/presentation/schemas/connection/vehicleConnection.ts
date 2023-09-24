import {connectionDefinitions} from "graphql-relay";
import {vehicleType} from "../types/vehicleType";

const { connectionType: vehicleConnection } = connectionDefinitions({
    nodeType: vehicleType,
});

export {vehicleConnection}
import {connectionDefinitions} from "graphql-relay";
import vehicleInterface from "../interfaces/Vehicle";

const { connectionType: vehicleConnection } = connectionDefinitions({
    nodeType: vehicleInterface,
});

export {vehicleConnection}
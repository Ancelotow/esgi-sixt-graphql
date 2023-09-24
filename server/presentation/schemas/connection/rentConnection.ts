import {connectionDefinitions} from "graphql-relay";
import {rentType} from "../types/rentType";

const { connectionType: rentConnection } = connectionDefinitions({
    nodeType: rentType,
});

export {rentConnection}
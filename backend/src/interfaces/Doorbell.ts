import internal from "stream";
import { Account } from "./Authentication";

export interface Ring {
    at: number, // When the doorbell was rang
    did: number, // ID of the doorbell
    media?: string, // [Optional] Video/image of person at the door
}

export interface Device {
    id: string,
    location: string,
    firststartup: number,
    group: string,
    owner: Account,
    type: deviceTypes, // Type of doorbell, e.g. with/without camera
}

export type deviceTypes = "MEDIA_ENABLED" | "MEDIA_DISABLED";
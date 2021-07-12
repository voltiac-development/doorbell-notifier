import { Device } from "../interfaces/Doorbell.js"
import { sql } from "./knex.js";


export async function addDeviceToDB(device: Device): Promise<{ data: Device, error: Error }> {
    let r = {
        data: null,
        error: null,
    }
    
    try {
        r.data = await sql<Device>('devices').insert(device)
    } catch (e) {
        r.error = e;
    }

    return {
        data: r.data,
        error: r.error
    };
}


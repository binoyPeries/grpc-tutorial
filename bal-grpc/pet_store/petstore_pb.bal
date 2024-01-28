import ballerina/grpc;
import ballerina/protobuf;

public const string PETSTORE_DESC = "0A0E70657473746F72652E70726F746F120870657473746F726522650A03506574120E0A0269641801200128055202696412120A046E616D6518022001280952046E616D6512120A047479706518032001280952047479706512140A0562726565641804200128095205627265656412100A036167651805200128055203616765221F0A0D47657450657452657175657374120E0A0269641801200128055202696422620A104372656174655065745265717565737412120A046E616D6518022001280952046E616D6512120A047479706518032001280952047479706512140A0562726565641804200128095205627265656412100A03616765180520012805520361676532710A0850657453746F726512300A0667657450657412172E70657473746F72652E476574506574526571756573741A0D2E70657473746F72652E50657412330A06416464506574121A2E70657473746F72652E437265617465506574526571756573741A0D2E70657473746F72652E506574620670726F746F33";

public isolated client class PetStoreClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, PETSTORE_DESC);
    }

    isolated remote function getPet(GetPetRequest|ContextGetPetRequest req) returns Pet|grpc:Error {
        map<string|string[]> headers = {};
        GetPetRequest message;
        if req is ContextGetPetRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("petstore.PetStore/getPet", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Pet>result;
    }

    isolated remote function getPetContext(GetPetRequest|ContextGetPetRequest req) returns ContextPet|grpc:Error {
        map<string|string[]> headers = {};
        GetPetRequest message;
        if req is ContextGetPetRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("petstore.PetStore/getPet", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Pet>result, headers: respHeaders};
    }

    isolated remote function AddPet(CreatePetRequest|ContextCreatePetRequest req) returns Pet|grpc:Error {
        map<string|string[]> headers = {};
        CreatePetRequest message;
        if req is ContextCreatePetRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("petstore.PetStore/AddPet", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Pet>result;
    }

    isolated remote function AddPetContext(CreatePetRequest|ContextCreatePetRequest req) returns ContextPet|grpc:Error {
        map<string|string[]> headers = {};
        CreatePetRequest message;
        if req is ContextCreatePetRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("petstore.PetStore/AddPet", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Pet>result, headers: respHeaders};
    }
}

public client class PetStorePetCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendPet(Pet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextPet(ContextPet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextGetPetRequest record {|
    GetPetRequest content;
    map<string|string[]> headers;
|};

public type ContextCreatePetRequest record {|
    CreatePetRequest content;
    map<string|string[]> headers;
|};

public type ContextPet record {|
    Pet content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: PETSTORE_DESC}
public type GetPetRequest record {|
    int id = 0;
|};

@protobuf:Descriptor {value: PETSTORE_DESC}
public type CreatePetRequest record {|
    string name = "";
    string 'type = "";
    string breed = "";
    int age = 0;
|};

@protobuf:Descriptor {value: PETSTORE_DESC}
public type Pet record {|
    int id = 0;
    string name = "";
    string 'type = "";
    string breed = "";
    int age = 0;
|};


@isTest
global class ProjectCalloutServiceMockTest implements HttpCalloutMock {
    //Implement http mock callout here
    global HTTPResponse respond(HTTPRequest request) {
    // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(201);
        response.setStatus('Created');
        return response; 
    }
    
    //Implement http mock callout here
    global HTTPResponse respond1(HTTPRequest request) {
    // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setStatus('Bad Request');
        return response; 
    }
}
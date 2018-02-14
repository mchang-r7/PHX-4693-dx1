@isTest
public class MetasploitServiceMock implements HttpCalloutMock {

    public static String getValidateEmailResponseBody(HttpRequest req) {
        return '<result email=\'bugs@test.acme.com\' reason=\'\' valid=\'true\'/>';
    }

    public static HttpResponse newValidateEmailResponse(HttpRequest req) {

        // Initialize the response
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setHeader('Content-Type', 'text/xml');

        // Set the body
        res.setBody(getValidateEmailResponseBody(req));

        // Return the response
        return res;
    }

    public HttpResponse respond(HttpRequest req) {
        return newValidateEmailResponse(req);
    }
}
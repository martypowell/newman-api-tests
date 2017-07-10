// var chakram = require('./../node_modules/chakram/dist/chakram.js'),
//     expect = chakram.expect;

// describe("GetStreet", function() {
//     it("should return a list of street names", function () {
//         var response = chakram.get("http://refuse.baltimorecountymd.gov/GetCWStreetWebService.asmx/GetCWStreet");
//         expect(response).to.have.status(200);
//         return chakram.wait();
//     });
// });

var chakram = require('chakram'),
    expect = chakram.expect;

describe("Chakram", function() {
    var getStreetsUrl = "http://refuse.baltimorecountymd.gov/GetCWStreetWebService.asmx/GetCWStreet";

    let requestData = {
        "prefixText":"W",
        "count":0
    };

    let options = {
        headers: [{
            json: true
        }]
    };

    it("should offer simple HTTP request capabilities", function () {
        chakram.setRequestDefaults({jar: true});
        console.log(requestData, options)
        var response = chakram.post(getStreetsUrl, requestData, options);
        
        expect(response).to.have.status(200);

        return chakram.wait();
    });
});
var AWS = require('aws-sdk');

var db = new AWS.DynamoDB.DocumentClient({
    'region': 'eu-west-1',
    'version': '2012-08-10',
});

exports.kolonialFindByEanOrId = function(event, context) {
	if (event.ean) {
		findByEan(event.ean, handleResponse);
	} else {
		findById(event.id, handleResponse);
	}

	function handleResponse(err, data) {
		if (data && data.Count > 0) {
			var item = data.Items[0];
			context.succeed(item);
		}
		context.fail("Item not found");
	}
};

function findById(id, callback)
{
	id = parseInt(id, 10);
	db.query({
		TableName : "products",
		KeyConditionExpression: 'id = :id',
		ExpressionAttributeValues: {
			':id': id
		}
	}, callback);
}

function findByEan(ean, callback)
{
	db.query({
		TableName: 'products',
		IndexName: 'ean-index',
		KeyConditionExpression: 'ean = :ean',
		ExpressionAttributeValues: {
			':ean': ean
		}
	}, callback);
}

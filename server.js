if(process.env.NODE_ENV !== 'production'){
	require('./secret.js')
}

require('coffee-script');

require('./app');
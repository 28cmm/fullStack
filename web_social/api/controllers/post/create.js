module.exports = async function(req, res) {
    const postBody = req.body.postBody
    console.log("Create post object with text: " + postBody)

    const file = req.file('imagefile')
    console.log(file)

    // I want to upload my file above
    const options =
    { // This is the usual stuff
        adapter: require('skipper-better-s3')
        , key: 'AKIAJT4VSZ3I4TRK6QAQ'
        , secret: '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'
        , bucket: 'fullstack-buckets'
        // Let's use the custom s3params to upload this file as publicly
        // readable by anyone
        , s3params:
            { ACL: 'public-read'
            }
        // And while we are at it, let's monitor the progress of this upload
        , onProgress: progress => sails.log.verbose('Upload progress:', progress)
    }

    file.upload(options, async (err, files) => {
        if (err) { return res.serverError(err.toString()) }

        // success
        // res.send(files)
        // console.log(files)

        const fileUrl = files[0].extra.Location
        const userId = req.session.userId
        await Post.create({text: postBody, 
            user: userId,
            imageUrl: fileUrl,
        }).fetch()

        res.redirect('/post')
    })

}



// module.exports = async function(req, res) {
//     const postBody = req.body.postBody
//     console.log("Create post object with text: " + postBody)

//     const file = req.file('imagefile')
//     console.log(file)

//     // I want to upload my file above
//     const options =
//     { // This is the usual stuff
//         adapter: require('skipper-better-s3')
//         , key: 'AKIAJT4VSZ3I4TRK6QAQ'
//         , secret: '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'
//         , bucket: 'fullstack-buckets'
//         // Let's use the custom s3params to upload this file as publicly
//         // readable by anyone
//         , s3params:
//             { ACL: 'public-read'
//             }
//         // And while we are at it, let's monitor the progress of this upload
//         , onProgress: progress => sails.log.verbose('Upload progress:', progress)
//     }

//     file.upload(options, async (err, files) => {
//         if (err) { return res.serverError(err.toString()) }
//         const fileUrl = files[0].extra.Location
//         // console.log(fileUrl)
//         // res.send(fileUrl)
//         const userId = req.session.userId
//         await Post.create({text: postBody, 
//             user: userId,
//             imageUrl: fileUrl
//         }).fetch()

//         res.redirect('/post')
//     })

   
// }
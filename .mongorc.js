DBCollection.prototype.findOneById = DBCollection.prototype.fbi = function(id)
{
        if (!id) return 'idを入れてください';
        if (typeof id !== 'string') id = String(id);
        return this.findOne({_id:ObjectId(id)});
};

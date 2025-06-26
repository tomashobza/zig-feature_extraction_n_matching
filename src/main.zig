const std = @import("std");
const zigimg = @import("zigimg");

pub fn invert_colors(image: zigimg.Image) void {
    for (image.pixels.rgb24) |*pixel| {
        pixel.r = 255 - pixel.r;
        pixel.g = 255 - pixel.g;
        pixel.b = 255 - pixel.b;
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var image = try zigimg.Image.fromFilePath(allocator, "0009.ppm");
    defer image.deinit();

    invert_colors(image);
    try image.writeToFilePath("output.png", .{ .png = .{} });
    std.debug.print("Image processing complete. Output saved to 'output.ppm'.\n", .{});
}

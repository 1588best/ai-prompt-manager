import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";

export async function GET() {
  try {
    const { data, error } = await supabase
      .from("prompts")
      .select("count(*)")
      .single();

    if (error) {
      return NextResponse.json(
        { error: "Database connection failed", details: error },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: "Database connection successful",
    });
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to connect to database" },
      { status: 500 }
    );
  }
}
